# Migrate from Install-Frontend to Install-ScPackage

With Dizzy 3.0 the `Install-Frontend` command was deprecated and new command called
`Install-ScPackage` was introduced. While `Install-Frontend` was able to install exactly one 
NuGet package, Install-ScPackage is now able to install multiple NuGet packages 
to multiple locations inside the web-root. Optionally a fix version or a version pattern can be specified for each package.
Read more about the configuration in the [Dizzy docs](README.md).

## How to migrate from Install-Frontend to Install-ScPackage   
To be able to use the Install-ScPackage feature in your project you need to perform the following steps: 

0. Update Dizzy to a version newer than 3.0
0. Add the `NugetPackages` config key in the Bob.config according to [Dizzy docs](README.md). `
The `FrontendPackage` and the `FrontendOutputDirectoryPath` can then be removed from the Bob.config.
0. Add `<ActivateModernInstallFrontendInBump>1</ActivateModernInstallFrontendInBump>` to the Bob.config
0. If you have an `Install-Frontend` command in your commands.json, update it accordingaly
0. On TeamCity, disable the `Install Frontend` step and create a Powershell step with the following source code: 
```
$ErrorActionPreference = "Stop"

trap {
  Write-Host $_
  $nuget = "%teamcity.tool.NuGet.CommandLine.DEFAULT.nupkg%\tools\nuget.exe"
  iex "$nuget sources remove -Name tc -Source %teamcity.nuget.feed.auth.server%"
  
  Write-Error $_
}
$ErrorActionPreference = "Stop"
Write-Host "##teamcity[progressMessage 'Install Frontend']"

Import-Module %unic.nuget.packages%/Unic.Bob.Dizzy.*/Dizzy

$nuget = "%teamcity.tool.NuGet.CommandLine.DEFAULT.nupkg%\tools\nuget.exe"

iex "$nuget sources add -Name tc -Source %teamcity.nuget.feed.auth.server% -UserName %system.teamcity.auth.userId% -Password %system.teamcity.auth.password%"

Install-ScNugetPackage -OutputDirectory "%unic.build.output.websites%"

Write-Host "Finished with installing Frontend"

iex "$nuget sources remove -Name tc -Source %teamcity.nuget.feed.auth.server%"
Write-Host "Removed TC source"
```

