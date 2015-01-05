$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
Import-Module "$here\dizzy.psm1"

Describe "Set-TeamcityVariablesFromMetadata" {
    Context "When there is origin in the branch-name" {
        "{'build-branch': 'origin/develop'}" | Out-File "TestDrive:\metadata.json" -Encoding UTF8

        Mock Write-Host {} -Verifiable -ParameterFilter { $Object -eq "##teamcity[setParameter name='dizzy.buildBranch' value='develop']" } -Module Dizzy

        Set-TeamcityVariablesFromMetadata "TestDrive:\metadata.json"

        It "Should have set branch name without origin" {
            Assert-VerifiableMocks
        }
    }
}
