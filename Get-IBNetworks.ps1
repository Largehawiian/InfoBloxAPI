<#
.SYNOPSIS
    Get IPv4 Networks from Infoblox
.DESCRIPTION
    Get IPv4 Networks from Infoblox
.NOTES

.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Get-IBNetworks.ps1 -ServerIP "192.168.1.2" -Credential $Credentials
#>
Function Get-IBNetworks {
    Param(
        [Parameter(Mandatory = $True)][String]$ServerIP,
        [Parameter(Mandatory = $True)][pscredential]$Credential
    )
    $URI = [System.UriBuilder]::new()
    $URI.Scheme = "https"
    $URI.Host = $ServerIP
    $URI.Path = "/wapi/v2.11.2/network"

    $Out = Invoke-RestMethod -Uri $URI.Uri -Credential $Credential -Method Get -ContentType "application/json"
    $Return = $Out | ForEach-Object { [PSCustomObject]@{
            Network     = $_.Network
            NetworkView = $_.Network_view
        }
    }
    return $Return
}
