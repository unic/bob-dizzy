function Set-TeamcityVariables
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [string] $MetaDataJsonPath
  )
  Process
  {
    $metadata = Get-Content -Raw $MetaDataJsonPath | ConvertFrom-Json
    PublishTeamCityVariable -Key "id" -Value $metadata.id
    PublishTeamCityVariable -Key "buildBranch" -Value $metadata."build-branch"
    PublishTeamCityVariable -Key "buildVersion" -Value $metadata."build-version"
  }
}


function PublishTeamCityVariable
{
    Param(
    [Parameter(Mandatory=$true)]
    [string] $Key,
    [string] $Value
    )

    Write-Host "##teamcity[setParameter name='dizzy.$Key' value='$Value']"
}
