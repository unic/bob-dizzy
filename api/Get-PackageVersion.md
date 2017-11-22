

# Get-PackageVersion

Gets the version to use for building a NuGet package
## Syntax

    Get-PackageVersion [-Branch] <String> [-MetaDataJsonPath] <String> [-MajorMinorPatch] <String> [<CommonParameters>]


## Description

Get-PackageVersion calculates the version to use,
when a frontend NuGet package is built.





## Parameters

    
    -Branch <String>
_The name of the build-* branch from which the NuGet package is built._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -MetaDataJsonPath <String>
_The path to the JSON file containing the metadata of a frontend build._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -MajorMinorPatch <String>
_The MajorMinorPatch part of the version._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-PackageVersion build-develop .\metdata.json 1.2.3































