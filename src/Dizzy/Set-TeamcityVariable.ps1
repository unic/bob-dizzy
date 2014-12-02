function Set-TeamcityVariable
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Key,
        [string] $Value
    )
    Process
    {

        Write-Host "##teamcity[setParameter name='dizzy.$Key' value='$Value']"
    }
}
