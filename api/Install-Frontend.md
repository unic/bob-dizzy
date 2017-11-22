

# Install-Frontend

[Deprecated] Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)
Installs locally the correct frontend package depending on context.
## Syntax

    Install-Frontend [[-Name] <String>] [[-ProjectPath] <String>] [[-Branch] <String>] [[-Version] <String>] [<CommonParameters>]


## Description

[Deprecated] Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)
Installs the newest frontend package. By default it installs the frontend to the WebRoot. It is possible to install frontend to the custom directory by setting the relative path with FrontendOutputDirectoryPath node in Bob.config.





## Parameters

    
    -Name <String>
_If the `Name` will be specified, this prerelease will be used instead of the current branch name._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false |  | false | false |


----

    
    
    -ProjectPath <String>
_The path to the website project. If it's not specified, the current Visual Studio website project will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    
    
    -Branch <String>
_The branch name to use to find the correct frontend pacakge.
If it's not specified the current branch will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    
    
    -Version <String>
_The version (Major, Minor, Patch) of the frontend package to install.
If it's not specified, the version will be calculated with GitVersion.
If no frontend package with this version exists, the latest release will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-Frontend






























### -------------------------- EXAMPLE 2 --------------------------
    Install-Frontend -Name myFeatureBranch































