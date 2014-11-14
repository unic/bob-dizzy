function Get-PackageVersion
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $Branch,
      [Parameter(Mandatory=$true)]
      [string] $MetaDataJsonPath
  )
  Process
  {
    $metadata = Get-Content -Raw $MetaDataJsonPath | ConvertFrom-Json
    # TODO get from git
    $version = "0.1"
    $buildBranch = $metadata.'build-branch'
    $paddedBuildNumber = "{0:D4}" -f [int]$metadata.'build-version'
    if($Branch -eq "build-develop") {
        $version + "-develop" + $paddedBuildNumber
    }
    elseif($Branch -eq "build-release")  {
        $version + "-release" + $paddedBuildNumber
    }
    else {
        $localBuildBranch = $buildBranch -replace "origin/", ""
        $featureBranch = $localBuildBranch -replace "feature/", ""
        $version + "-" + $featureBranch + $paddedBuildNumber
    }
  }
}
