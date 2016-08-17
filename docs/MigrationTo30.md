# Migrate from Install-Frontend to Install-ScNugetPackage

With Dizzy 3.0 the `Install-Frontend` command was deprecated and new command called
`Install-ScNugetPackage` was introduced. While `Install-Frontend` was able to install exactly one 
NuGet package, Install-ScNugetPackage is now able to install multiple NuGet packages 
to multiple locations inside the web-root. Optionally a fix version or a version pattern can be specified for each package.
Read more about the configuration in the [Dizzy docs](README.md).

## How to migrate from Install-Frontend to Install-ScNugetPackage
To be able to use the Install-ScNugetPackage feature in your project you need to perform the following steps: 

0. Update Dizzy to a version newer than 3.0
0. Add the `NugetPackages` config key in the Bob.config according to [Dizzy docs](README.md). `
The `FrontendPackage` and the `FrontendOutputDirectoryPath` can then be removed from the Bob.config.
0. Update Scoop to at least version 2.3
0. Add `<BumpInstallNugetPackages>1</BumpInstallNugetPackages>` and `<BumpDisableInstallFrontend>1</BumpDisableInstallFrontend>` to the Bob.config
0. If you have an `Install-Frontend` command in your commands.json, update it accordingaly
0. On TeamCity, disable the `Install Frontend` step

