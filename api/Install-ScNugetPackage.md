

# Install-ScNugetPackage

Installs all configured NuGet packages to the webroot or to the specified path.
## Syntax

    Install-ScNugetPackage [[-NugetPackage] <String[]>] [[-OutputDirectory] <String>] [[-ProjectPath] <String>] [<CommonParameters>]


## Description

Installs all NuGet packages which are configured in the Bob.config
either to the web-root or to the specified directory.





## Parameters

    
    -NugetPackage <String[]>
_If the `NugetPackage` parameter is specified only the this packages wil be installed.
If nothing is specified all packages will be installed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | false |  | false | false |


----

    
    
    -OutputDirectory <String>
_The directory where the packages will be extracted. 
If nothing is specified, the packages will be installed to the web-root._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    
    
    -ProjectPath <String>
_The path to the website project. If it's not specified, the current Visual Studio website project will be used._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Install-ScNugetPackage






























### -------------------------- EXAMPLE 2 --------------------------
    Install-ScNugetPackage Customer.Frontend






























### -------------------------- EXAMPLE 3 --------------------------
    Install-ScNugetPackage -OutputDirectory D:\work\project\packing































