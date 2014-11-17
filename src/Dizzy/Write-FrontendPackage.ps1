function Write-FrontendPackage
{
  [CmdletBinding()]
  Param(
      [Parameter(Mandatory=$true)]
      [string] $Version,
      [Parameter(Mandatory=$true)]
      [string] $Id,
      [Parameter(Mandatory=$true)]
      [string] $Path,
      [Parameter(Mandatory=$true)]
      [string] $OutputLocation
  )
  Process
  {
    $nuget = ResolvePath -PackageId "NuGet.CommandLine" -RelativePath "tools\NuGet.exe"
    $templateNuspec = Resolve-Path "$PSScriptRoot\..\NuGet\Frontend.nuspec.template"
    $nuspec = "${env:TEMP}\Frontend.nuspec"
    cp $templateNuspec $nuspec -Force

    & $nuget pack $nuspec -p "ID=$Id" -version $Version -BasePath $Path -o $OutputLocation
  }
}
