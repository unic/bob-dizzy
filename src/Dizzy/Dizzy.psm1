$ErrorActionPreference = "Stop"

$PSScriptRoot = Split-Path  $script:MyInvocation.MyCommand.Path

function ResolvePath() {
  param($PackageId, $RelativePath)
  $paths = @("$PSScriptRoot\..\..\lib", "$PSScriptRoot\..\..\packages", "$PSScriptRoot\..\tools")
  foreach($packPath in $paths) {
    $path = Join-Path $packPath "$PackageId\$RelativePath"
    if((Test-Path $packPath) -and (Test-Path $path)) {
      Resolve-Path $path
      return
    }
  }
  Write-Error "No path found for $RelativePath in package $PackageId"
}

Get-ChildItem -Path $PSScriptRoot\*.ps1 -Exclude *.tests.ps1 | Foreach-Object{ . $_.FullName }
Export-ModuleMember -Function * -Alias *

Import-Module (ResolvePath "Unic.Bob.Wendy" "tools\Wendy") -force
Import-Module (ResolvePath "Unic.Bob.Skip" "Skip") -Force
$VerbosePreference = "Continue"
[System.Reflection.Assembly]::LoadFrom((ResolvePath "Nuget.Core" "lib\net40-client\NuGet.Core.dll"))
[System.Reflection.Assembly]::LoadFrom((ResolvePath "LibGit2Sharp" "LibGit2Sharp.dll"))
[System.Reflection.Assembly]::LoadFrom((ResolvePath "GitVersion" "lib\net45\GitVersionCore.dll"))
[System.Reflection.Assembly]::LoadFrom((Resolve-Path "NuGet.CommandLine" "tools\NuGet.exe"))
