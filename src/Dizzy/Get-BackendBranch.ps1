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
            Invoke-WebRequest $url -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} |
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
