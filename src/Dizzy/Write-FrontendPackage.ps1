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
      [string] $OutputLocation,
      [string[]] $Folders = @("assets")
  )
  Process
  {
    $nuget = ResolvePath -PackageId "NuGet.CommandLine" -RelativePath "tools\NuGet.exe"
    $templateNuspec = Resolve-Path "$PSScriptRoot\..\NuGet\Frontend.nuspec.template"

    $template = Get-Content $templateNuspec
    $files = ""
    foreach($folder in $folders) {
         $files += "<file src=""$folder/**"" />"
    }
    $template = $template -replace "##FILES##", $files
    $nuspec = "${env:TEMP}\Frontend.nuspec"
    $template | Out-File $nuspec -Encoding UTF8

    & $nuget pack $nuspec -p "ID=$Id" -version $Version -BasePath $Path -o $OutputLocation
    if($LASTEXITCODE -ne 0) {
        Write-Error "NuGet package generation failed"
    }
  }
}
