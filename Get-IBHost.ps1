<#
.SYNOPSIS
    Returns a specified host from Infoblox
.DESCRIPTION
    Returns a specified host from Infoblox
.NOTES

.LINK

.EXAMPLE
    Get-IBHost.ps1 -ServerIP "192.168.1.2" -Credential $Credentials -ComputerName "Server1"
#>
Function Get-IBHost {
    Param(
        [Parameter(Mandatory = $True)][String]$ServerIP,
        [Parameter(Mandatory = $True)][pscredential]$Credential,
        [Parameter(Mandatory = $True)][String]$ComputerName
    )
    $URI = [System.UriBuilder]::new()
    $URI.Scheme = "https"
    $URI.Host = $ServerIP
    $URI.Path = "/wapi/v2.11.2/record:host"
    $URI.Query = "name=$ComputerName"

    $Out = Invoke-RestMethod -Uri $URI.Uri -Credential $Credential -Method Get -ContentType "application/json"
    $Return = $Out.ipv4addrs | ForEach-Object { [PSCustomObject]@{
            HostName  = $_.Host
            IPAddress = $_.Ipv4addr
        }
    }
    return $Return
}