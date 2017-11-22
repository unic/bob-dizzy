

# Set-TeamcityVariablesFromMetadata

Sets different TeamCity parameters from a specific metadata.json file.
## Syntax

    Set-TeamcityVariablesFromMetadata [-MetaDataJsonPath] <String> [<CommonParameters>]


## Description

Sets the build-id, build-branch and the build-version from a specific metadata.json file
as TeamCity variable.





## Parameters

    
    -MetaDataJsonPath <String>
_The path to the metadata json._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Set-TeamcityVariablesFromMetadata -MetaDataJsonPath .\metdata.json































