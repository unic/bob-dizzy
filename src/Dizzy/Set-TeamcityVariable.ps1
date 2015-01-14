<#
.SYNOPSIS
Sets the value of specific Dizzy TeamCity parameter.

.DESCRIPTION
Sets the value of specific Dizzy TeamCity parameter,
with the help of TeamCity system messages.

.PARAMETER Key
The key of the parameter to set.
The exact TeamCity parameter will be "dizzy.$Key"

.PARAMETER Value
The value to set to the parameter.

.EXAMPLE
Set-TeamcityVariable -Key version -Value 1.2.3

#>
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
