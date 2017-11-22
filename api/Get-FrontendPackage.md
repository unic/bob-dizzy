

# Get-FrontendPackage

Gets a frontend package for the corresponding backend branch.
## Syntax

    Get-FrontendPackage [-Branch] <String> [-PackageId] <String> [-Source] <String> [[-Prerelease] <String>] [[-Version] <String>] [[-ProjectPath] <String>] [<CommonParameters>]


## Description

Gets a frontend package for the corresponding backend branch
with optionally a specific version and specific prerelase tag.
For more information about the exact algorithm check the dizzy docs.





## Parameters

    
    -Branch <String>
_The name of the backend branch._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -PackageId <String>
_The NuGet id of the frontend package to download._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Source <String>
_The NuGet feed url to use to search the package._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -Prerelease <String>
_If the Prerelease parameter is specified, this one will be taken instead of "develop" or "release"_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | false |  | false | false |


----

    
    
    -Version <String>
_The version without prerelease to use._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | false | * | false | false |


----

    
    
    -ProjectPath <String>

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed






























### -------------------------- EXAMPLE 2 --------------------------
    Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed  -Version 0.1






























### -------------------------- EXAMPLE 3 --------------------------
    Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed  -Prerelease myFeatureBranch































