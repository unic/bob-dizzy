

# Start-TeamcityBuild

Starts a new build of a specific TeamCtiy build configuration with a specific branch.
## Syntax

    Start-TeamcityBuild [-BuildId] <String> [-Url] <String> [-User] <String> [-Password] <String> [-Branch] <String> [<CommonParameters>]


## Description

Starts a new build of a specific TeamCtiy build configuration with a specific branch
on a specific TeamCity server.





## Parameters

    
    -BuildId <String>
_The id of the TeamCity build configuration._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Url <String>
_The TeamCity base url._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | true |  | false | false |


----

    
    
    -User <String>
_The user to log in the TeamCity._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 3 | true |  | false | false |


----

    
    
    -Password <String>
_The password of the $User_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 4 | true |  | false | false |


----

    
    
    -Branch <String>
_The branch to start the build for._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 5 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Start-TeamcityBuild -BuildId Sitecore_Project_Build -Url https://teamcity.unic.com -User myuser -Password mypass -Branch develop































