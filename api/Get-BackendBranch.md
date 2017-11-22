

# Get-BackendBranch

Gets a backend branch based on a frontend branch by querying Stash.
## Syntax

    Get-BackendBranch [-FrontendBranch] <String> [-StashUrl] <String> [-Project] <String> [-Repo] <String> [-UserName] <String> [-Password] <SecureString> [<CommonParameters>]


## Description

Get-BackendBranch queries the API of Atlassion Stash to find a matching branch.
This is used to make sure release/1.0 matches release/1.0.0 and to ensure that a corresponding branch really exists.





## Parameters

    
    -FrontendBranch <String>
_The branch to use as base._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -StashUrl <String>
_The base url to Stash e.g https://git.unic.com_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -Project <String>
_The key of the project in Stash._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -Repo <String>
_The key of the repository in stash. E.g. sitecore-website_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -UserName <String>
_The username to connect to Stash._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | true |  | false | false |


----

    
    
    -Password <SecureString>
_The password to connect to Stash_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 6 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-BackendBranch -FrontendBranch "release/1.7" -StashUrl https://git.unic.com -Project JURA -Repo sitecore-website -UserName yannis.guedel -Password (ConvertTo-SecureString verySecure -AsPlainText -Force)































