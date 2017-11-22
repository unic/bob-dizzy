$PSScriptRoot = split-path -parent $MyInvocation.MyCommand.Definition

$module = "Dizzy"

Import-Module "$PSScriptRoot\packages\Unic.Bob.Keith\Keith"
Import-Module "$PSScriptRoot\src\$module" -Force

New-PsDoc -Module $module -Path "$PSScriptRoot\docs\" -OutputLocation "$PSScriptRoot\docs-generated"

New-GitBook "$PSScriptRoot\docs-generated" "$PSScriptRoot\temp"
