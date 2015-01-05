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
