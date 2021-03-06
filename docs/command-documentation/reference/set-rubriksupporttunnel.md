---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/set-rubriksupporttunnel
schema: 2.0.0
---

# Set-RubrikSupportTunnel

## SYNOPSIS
Sets the configuration of the Support Tunnel

## SYNTAX

```
Set-RubrikSupportTunnel [-EnableTunnel] [[-Timeout] <Int32>] [[-Server] <String>] [[-api] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Set-RubrikSupportTunnel cmdlet is used to update a Rubrik cluster's Support Tunnel configuration
This tunnel is used by Rubrik's support team for providing remote assistance and is toggled on or off by the cluster administrator

## EXAMPLES

### EXAMPLE 1
```
Set-RubrikSupportTunnel -EnableTunnel:$false
```

This will disable the Support Tunnel for the Rubrik cluster

### EXAMPLE 2
```
Set-RubrikSupportTunnel -EnableTunnel
```

This will enable the Support Tunnel for the Rubrik cluster and set the inactivity timeout to infinite (no timeout)

### EXAMPLE 3
```
Set-RubrikSupportTunnel -EnableTunnel -Timeout 100
```

This will enable the Support Tunnel for the Rubrik cluster and set the inactivity timeout to 100 seconds

## PARAMETERS

### -EnableTunnel
Status of the Support Tunnel.
Choose to enable or -EnableTunnel:$false to disable.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: isTunnelEnabled

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
Tunnel inactivity timeout in seconds.
Only valid when setting $EnableTunnel to $true.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: inactivityTimeoutInSeconds

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Rubrik server IP or FQDN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $global:RubrikConnection.server
Accept pipeline input: False
Accept wildcard characters: False
```

### -api
API version

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $global:RubrikConnection.api
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by Chris Wahl for community usage
Twitter: @ChrisWahl
GitHub: chriswahl

## RELATED LINKS

[https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/set-rubriksupporttunnel](https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/set-rubriksupporttunnel)

