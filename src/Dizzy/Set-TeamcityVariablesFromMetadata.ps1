<#
.SYNOPSIS
Sets different TeamCity parameters from a specific metadata.json file.

.DESCRIPTION
Sets the build-id, build-branch and the build-version from a specific metadata.json file
as TeamCity variable.

.PARAMETER MetaDataJsonPath
The path to the metadata json.

.EXAMPLE
Set-TeamcityVariablesFromMetadata -MetaDataJsonPath .\metdata.json
#>
function Set-TeamcityVariablesFromMetadata
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [string] $MetaDataJsonPath
  )
  Process
  {
    $metadata = Get-Content -Raw $MetaDataJsonPath | ConvertFrom-Json
    Set-TeamcityVariable -Key "id" -Value $metadata.id
    $buildBranch = $metadata."build-branch" -replace "origin/", ""
    Set-TeamcityVariable -Key "buildBranch" -Value $buildBranch
    Set-TeamcityVariable -Key "buildVersion" -Value $metadata."build-version"
  }
}
