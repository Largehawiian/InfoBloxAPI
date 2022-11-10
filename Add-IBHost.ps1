<#
.SYNOPSIS
    Add a host to Infoblox
.DESCRIPTION
    Add a host to Infoblox
.NOTES

.LINK

.EXAMPLE
    Add-IBHost -ServerIP "192.168.1.2" -Credential $Credentials -Name "Hostname.Domain.com" -IP "172.16.100.2"
#>


function Add-IBHost {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$IP,
        [Parameter(Mandatory = $true)][pscredential]$Credential,
        [Parameter(Mandatory = $true)][string]$ServerIP
    )
    $URI = [System.UriBuilder]::new()
    $URI.Scheme = "https"
    $URI.Host = $ServerIP
    $URI.Path = "/wapi/v2.11.2/record:host"
    $Body = @{
        ipv4addrs = @(@{
                ipv4addr = $IP
            })
        name      = $Name
    } | ConvertTo-Json
    $Return = Invoke-RestMethod -Method post -Uri $URI.Uri -Credential $Credential -ContentType "application/json" -Body $Body
    return $Return
}