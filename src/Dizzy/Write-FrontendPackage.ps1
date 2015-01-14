<#
.SYNOPSIS
Creates a new frontend NuGet package.

.DESCRIPTION
Creates a new frontend NuGet package with a specific version, id and folders.
The template for the frontend package can be found under `..\NuGet\Frontend.nuspec.template`

.PARAMETER Version
The version the new NuGet package will get.

.PARAMETER Id
The NuGet package id the newe NuGet package will get.
.PARAMETER Path
The base path where of all folders, which must be included.
For example if D:\temp\scripts and D:\temp\styles should be included, $Path must be D:\temp

.PARAMETER OutputLocation
The folder where the resulting NuGet package should be placed.s

.PARAMETER Folders
An array of folders inside the $Path which must be included in the NuGet package.

.EXAMPLE
Write-FrontendPackage -Version 1.2.3 -Id My.Frontend -Path .\frontend -OutputLocation .\output

.EXAMPLE
Write-FrontendPackage -Version 1.2.3 -Id My.Frontend -Path .\frontend -OutputLocation .\output -Folders scripts,styles

#>
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
