<#
.SYNOPSIS
    Creates a new DNS Zone in Infoblox
.DESCRIPTION
    Creates a new DNS Zone in Infoblox
.NOTES

.LINK

.EXAMPLE
    New-IBDnsZone.ps1 -ServerIP "192.168.1.2" -Credential $Credentials -Name "Domain.com"
#>
Function New-IBDnsZone {
    param(
        [Parameter(Mandatory = $true)][string]$fqdn,
        [Parameter(Mandatory = $True)][pscredential]$Credential,
        [Parameter(Mandatory = $True)][String]$ServerIP
    )
    $URI = [System.UriBuilder]::new()
    $URI.Scheme = "https"
    $URI.Host = $ServerIP
    $URI.Path = "/wapi/v2.11.2/zone_auth"
    $Body = @{
        fqdn = $fqdn
    } | Convertto-Json
    $Return = Invoke-RestMethod -Method post -Uri $URI.Uri -Credential $Credential  -ContentType "application/json" -Body $Body
    return $Return
}
