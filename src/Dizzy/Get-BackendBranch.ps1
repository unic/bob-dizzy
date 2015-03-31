<#
.SYNOPSIS
Gets a backend branch based on a frontend branch by querying Stash.
.DESCRIPTION
Get-BackendBranch queries the API of Atlassion Stash to find a matching branch.
This is used to make sure release/1.0 matches release/1.0.0 and to ensure that a corresponding branch really exists.
.PARAMETER FrontendBranch
The branch to use as base.
.PARAMETER StashUrl
The base url to Stash e.g https://git.unic.com
.PARAMETER Project
The key of the project in Stash.
.PARAMETER Repo
The key of the repository in stash. E.g. sitecore-website
.PARAMETER UserName
The username to connect to Stash.
.PARAMETER Password
The password to connect to Stash

.EXAMPLE
Get-BackendBranch -FrontendBranch "release/1.7" -StashUrl https://git.unic.com -Project JURA -Repo sitecore-website -UserName yannis.guedel -Password (ConvertTo-SecureString verySecure -AsPlainText -Force)
#>
function Get-BackendBranch
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $FrontendBranch,
        [Parameter(Mandatory=$true)]
        [string] $StashUrl,
        [Parameter(Mandatory=$true)]
        [string] $Project,
        [Parameter(Mandatory=$true)]
        [string] $Repo,
        [Parameter(Mandatory=$true)]
        [string] $UserName,
        [Parameter(Mandatory=$true)]
        [SecureString] $Password
    )
    Process
    {
        $plainPw =
            [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))

        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $plainPw)))

        $url = "$StashUrl/rest/api/1.0/projects/$Project/repos/$Repo/branches?limit=1000"
        $branches =
            Invoke-WebRequest $url -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -UseBasicParsing |
                ConvertFrom-Json

        if($branches.isLastPage -ne "True") {
            Write-Error "There are too many branches (> 1000) in the repo $Repo of the project $Project"
        }

        switch -Regex ($FrontendBranch) {
            "develop" {
                ($branches.values | ? {$_.id -eq "refs/heads/develop"}).displayId
            }
            "(release|hotfix)\/(\d+)\.(\d+)(\.(\d)+)?" {
                $label = $matches[1]
                $major = $matches[2]
                $minor = $matches[3]
                $patch = $matches[5]
                if(-not $patch) {
                    $patch = "0"
                }
                ($branches.values | ? {$_.id -match "refs\/heads\/$label\/$major\.$minor(\.$patch)?"}).displayId
            }
        }
    }
}
