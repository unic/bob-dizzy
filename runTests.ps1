$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Import-Module $scriptPath\packages\Pester\tools\Pester.psm1

& {Invoke-Pester src -OutputFile TestResults.xml -OutputFormat NUnitXml -EnableExit}
