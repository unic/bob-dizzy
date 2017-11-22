

# Write-FrontendPackage

Creates a new frontend NuGet package.
## Syntax

    Write-FrontendPackage [-Version] <String> [-Id] <String> [-Path] <String> [-OutputLocation] <String> [[-Folders] <String[]>] [<CommonParameters>]


## Description

Creates a new frontend NuGet package with a specific version, id and folders.
The template for the frontend package can be found under `..\NuGet\Frontend.nuspec.template`





## Parameters

    
    -Version <String>
_The version the new NuGet package will get._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Id <String>
_The NuGet package id the new NuGet package will get._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Path <String>
_The base path of all folders to include.
For example if D:\temp\scripts and D:\temp\styles should be included, $Path must be D:\temp_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -OutputLocation <String>
_The folder where the resulting NuGet package should be placed._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -Folders <String[]>
_An array of folders inside the $Path to be included in the NuGet package._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | false | @("assets") | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Write-FrontendPackage -Version 1.2.3 -Id My.Frontend -Path .\frontend -OutputLocation .\output






























### -------------------------- EXAMPLE 2 --------------------------
    Write-FrontendPackage -Version 1.2.3 -Id My.Frontend -Path .\frontend -OutputLocation .\output -Folders scripts,styles































