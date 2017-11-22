

# Set-TeamcityVariable

Sets the value of specific Dizzy TeamCity parameter.
## Syntax

    Set-TeamcityVariable [-Key] <String> [[-Value] <String>] [<CommonParameters>]


## Description

Sets the value of specific Dizzy TeamCity parameter,
with the help of TeamCity system messages.





## Parameters

    
    -Key <String>
_The key of the parameter to set.
The exact TeamCity parameter will be "dizzy.$Key"_

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 1 | true |  | false | false |


----

    
    
    -Value <String>
_The value to set to the parameter._

| Position | Required | Default value | Accept pipeline input | Accept wildchard characters |
| -------- | -------- | ------------- | --------------------- | --------------------------- |
| 2 | false |  | false | false |


----

    

## Examples

### -------------------------- EXAMPLE 1 --------------------------
    Set-TeamcityVariable -Key version -Value 1.2.3































