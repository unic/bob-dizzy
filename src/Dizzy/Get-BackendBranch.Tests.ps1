$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

function TestGetBackendBranch {
    param($branch)

    Get-BackendBranch $branch dummy dummy dummy dummy (ConvertTo-SecureString dummy -AsPlainText -Force)
}

Describe "Get-BackendBranch" {
    Context "Get release branch with major minor" {

        Mock Invoke-WebRequest {"{isLastPage: 'True', values: [{id: 'refs/heads/release/0.1', displayId: 'release/0.1'}]}"}

        It "Should find with major, minor" {
            TestGetBackendBranch "release/0.1" | Should Be "release/0.1"
        }
        It "Should find with major, minor, patch" {
            TestGetBackendBranch "release/0.1.0" | Should Be "release/0.1"
        }
        It "Should not find with wrong" {
            TestGetBackendBranch "release/0.2.0" | Should Be $null
        }
    }
    Context "Get release branch with major, minor, patch" {

        Mock Invoke-WebRequest {"{isLastPage: 'True', values: [{id: 'refs/heads/release/0.1.0', displayId: 'release/0.1.0'}]}"}

        It "Should find with major, minor" {
            TestGetBackendBranch "release/0.1" | Should Be "release/0.1.0"
        }
        It "Should find with major, minor, patch" {
            TestGetBackendBranch "release/0.1.0" | Should Be "release/0.1.0"
        }
        It "Should not find with wrong" {
            TestGetBackendBranch "release/0.2.0" | Should Be $null
        }
    }
    Context "Get hotfix branch with major, minor, patch" {

        Mock Invoke-WebRequest {"{isLastPage: 'True', values: [{id: 'refs/heads/hotfix/0.1.1', displayId: 'hotfix/0.1.1'}]}"}

        It "Should find with major, minor, patch" {
            TestGetBackendBranch "hotfix/0.1.1" | Should Be "hotfix/0.1.1"
        }
        It "Should not find with wrong" {
            TestGetBackendBranch "release/0.1.1" | Should Be $null
        }
    }
}
