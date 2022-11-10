<#
.SYNOPSIS
    Get IPv4 IP Addresses from the referenced subnet in Infoblox
.DESCRIPTION
    Get IPv4 IP Addresses from the referenced subnet in Infoblox
.NOTES

.LINK

.EXAMPLE
    Get-IBIPv4Addresses.ps1 -ServerIP "192.168.1.2" -Credential $Credentials -Network "!72.16.100.0/24"
#>
Function Get-IBIPv4Addresses {
    Param(
        [Parameter(Mandatory = $True)][String]$ServerIP,
        [Parameter(Mandatory = $True)][pscredential]$Credential,
        [Parameter(Mandatory = $True)][String]$Network
    )
    $URI = [System.UriBuilder]::new()
    $URI.Scheme = "https"
    $URI.Host = $ServerIP
    $URI.Path = "/wapi/v2.11.2/ipv4address"
    $URI.Query = "network=$Network"

    $Out = Invoke-RestMethod -Uri $URI.Uri -Credential $Credential -Method Get -ContentType "application/json"
    $Return = $Out | ForEach-Object { [PSCustomObject]@{
            IPAddress = $_.ip_Address
            Name      = $_.names
            Network   = $_.Network
            Status    = $_.Status
            Types     = $_.Types
        }
    }
    return $Return
}