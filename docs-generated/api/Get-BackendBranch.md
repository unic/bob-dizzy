

# Get-BackendBranch

Gets a backend branch based on a frontend branch by querying Stash.
## Syntax

    Get-BackendBranch [-FrontendBranch] <String> [-StashUrl] <String> [-Project] <String> [-Repo] <String> [-UserName] <String> [-Password] <SecureString> [<CommonParameters>]


## Description

Get-BackendBranch queries the API of Atlassion Stash to find a matching branch.
This is used to make sure release/1.0 matches release/1.0.0 and to ensure that a coresponding branch really exists.





## Parameters

    
    -FrontendBranch <String>

The branch to use as base.





Required?  true

Position? 1

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -StashUrl <String>

The base url to Stash e.g https://git.unic.com





Required?  true

Position? 2

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Project <String>

The key of the project in Stash.





Required?  true

Position? 3

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Repo <String>

The key of the repository in stash. E.g. sitecore-website





Required?  true

Position? 4

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -UserName <String>

The username to connect to Stash.





Required?  true

Position? 5

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    
    
    -Password <SecureString>

The password to connect to Stash





Required?  true

Position? 6

Default value? 

Accept pipeline input? false

Accept wildchard characters? false
    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Get-BackendBranch -FrontendBranch "release/1.7" -StashUrl https://git.unic.com -Project JURA -Repo sitecore-website -UserName yannis.guedel -Password (ConvertTo-SecureString verySecure -AsPlainText -Force)































