#requires -Version 3
function Set-RubrikHyperVVM
{
    <#  
            .SYNOPSIS
            Applies settings on one or more virtual machines known to a Rubrik cluster

            .DESCRIPTION
            The Set-RubrikHyperVVM cmdlet is used to apply updated settings from a Rubrik cluster on any number of virtual machines

            .NOTES
            Written by Mike Fal for community usage
            Twitter: @Mike_Fal
            GitHub: MikeFal

            .LINK
            https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/set-rubrikhypervvm

            .EXAMPLE
            Get-RubrikHyperVVM 'Server1' | Set-RubrikHyperVVM -PauseBackups
            This will pause backups on any virtual machine named "Server1"

            .EXAMPLE
            Get-RubrikHyperVVM -SLA Platinum | Set-RubrikHyperVVM -SnapConsistency 'CRASH_CONSISTENT' -MaxNestedSnapshots 2 -UseArrayIntegration 
            This will find all virtual machines in the Platinum SLA Domain and set their snapshot consistency to crash consistent (no application quiescence)
            while also limiting the number of active hypervisor snapshots to 2 and enable storage array (SAN) snapshots for ingest
    #>

    [CmdletBinding(SupportsShouldProcess = $true,ConfirmImpact = 'High')]
    Param(
        # Virtual machine ID
        [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$id,
        #Raw Cloud Instantiation spec
        [hashtable]$cloudInstantiationSpec,
        # Rubrik server IP or FQDN
        [String]$Server = $global:RubrikConnection.server,
        # API version
        [String]$api = $global:RubrikConnection.api
    )

    Begin {

        # The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
        # If a command needs to be run with each iteration or pipeline input, place it in the Process section
    
        # Check to ensure that a session to the Rubrik cluster exists and load the needed header data for authentication
        Test-RubrikConnection
    
        # API data references the name of the function
        # For convenience, that name is saved here to $function
        $function = $MyInvocation.MyCommand.Name
        
        # Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
        Write-Verbose -Message "Gather API Data for $function"
        $resources = Get-RubrikAPIData -endpoint $function
        Write-Verbose -Message "Load API data for $($resources.Function)"
        Write-Verbose -Message "Description: $($resources.Description)"
  
    }

    Process {        
        
        $uri = New-URIString -server $Server -endpoint ($resources.URI) -id $id
        $uri = Test-QueryParam -querykeys ($resources.Query.Keys) -parameters ((Get-Command $function).Parameters.Values) -uri $uri
        $body = New-BodyString -bodykeys ($resources.Body.Keys) -parameters ((Get-Command $function).Parameters.Values)
        $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
        $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
        $result = Test-FilterObject -filter ($resources.Filter) -result $result

        return $result

    } # End of process
} # End of function