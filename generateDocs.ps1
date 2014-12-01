$PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition

$module = "Dizzy"

Import-Module "$PSScriptRoot\packages\Unic.Bob.Keith\Keith"
Import-Module "$PSScriptRoot\src\$module" -Force

New-PSApiDoc -ModuleName $module -Path "$PSScriptRoot\docs\"

gitbook build "$PSScriptRoot\docs\"
