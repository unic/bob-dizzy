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
    Set-TeamcityVariable -Key "buildBranch" -Value $metadata."build-branch"
    Set-TeamcityVariable -Key "buildVersion" -Value $metadata."build-version"
  }
}
