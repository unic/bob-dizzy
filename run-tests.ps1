$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Import-Module $scriptPath\packages\Pester\tools\Pester.psm1

$param = @{}
if($env:TEAMCITY_VERSION) {
    $param["EnableExit"] = $true
}

& {Invoke-Pester src -OutputXml TestResults.xml @param}
