<#
.SYNOPSIS
Installs locally the correct frontend package depending on context.

.DESCRIPTION
Installs the newest frontend package for the current branch to the local WebRoot.

.PARAMETER Name
If the `Name` will be specified, this prerelease will be used instead of the current branch name.

.PARAMETER ProjectPath
The path to the website project. If it's not specified, the current Visual Studio website project will be used.

.PARAMETER Branch
The branch name to use to find the correct frontend pacakge.
If it's not specified the current branch will be used.

.PARAMETER Version
The version (Major, Minor, Patch) of the frontend package to install.
If it's not specified, the version will be calculated with GitVersion.
If no frontend package with this version exists, the latest release will be used.

.EXAMPLE
Install-Frontend

.EXAMPLE
Install-Frontend -Name myFeatureBranch

#>
function Install-Frontend
{
    [CmdletBinding()]
    Param(
        [string] $Name,
        [string] $ProjectPath,
        [string] $Branch,
        [string] $Version
    )
    Process
    {
        $config = Get-ScProjectConfig $ProjectPath
        if(-not $config.GlobalWebPath -and -not $config.WebsiteCodeName -and -not $config.WebFolderName) {
            Write-Error "GlobalWebPath or WebsiteCodeName or WebFolderName are not configured."
        }
        $Location = "$($config.GlobalWebPath)\$($config.WebsiteCodeName)\$($config.WebFolderName)"

        if(-not $Location) {
            Write-Error "No Location could be found to extract."
        }

        $website = Resolve-Path $config.WebsitePath
        $repoDir = GetDirecectoryContainingSubdir $website ".git"
        if(-not $repoDir) {
            Write-Error "$website does not contain a git repository."
        }
        $LibGit2SharpName = [System.Reflection.AssemblyName]::GetAssemblyName((ResolvePath "LibGit2Sharp" "lib\net40\LibGit2Sharp.dll")).FullName
        $LibGit2Sharp = [AppDomain]::CurrentDomain.GetAssemblies() | ? {$_.FullName -eq $LibGit2SharpName}
        $Repository = $LibGit2Sharp.GetType("LibGit2Sharp.Repository")
        $repo = [System.Activator]::CreateInstance($Repository, $repoDir, $null)

        if(-not $branch) {
            $branch = $repo.Head.Name
            if($branch -eq "(no branch)") {
                Write-Error "HEAD is detached. Please ensure you are on a valid branch or provide the 'Branch' parameter."
            }
        }
        if(-not $Version) {
            [GitVersion.Logger]::WriteInfo = {}
            [GitVersion.Logger]::WriteWarning = {}
            [GitVersion.Logger]::WriteError = {}

            $gitVersionConfig = New-Object GitVersion.Config
            $ctx = New-Object GitVersion.GitVersionContext $repo, $gitVersionConfig
            $versionFinder = New-Object GitVersion.GitVersionFinder
            $Version = $versionFinder.FindVersion($ctx).ToString("j")
        }

        $packageId = $config.FrontendPackage
        if(-not $packageId) {
            Write-Error "Frontend package id could not be found. Make sure Bob.config contains the FrontendPackage key."
        }

        $source = $config.NuGetFeed
        if(-not $source) {
            Write-Error "Source for frontend package could not be found. Make sure Bob.config contains the NuGetFeed key."
        }

        $package = Get-FrontendPackage -Branch $Branch -PackageId $PackageId -Source $Source -Prerelease $Name -Version $Version
        if(-not $package) {
            "Frontend package form branch $Branch with the ID $PackageId in $Source could not be found."
        }

        if(-not (Test-Path $Location )) {
            Write-Verbose "Create directory $Location"
            mkdir $Location | Out-Null
        }
        $assetsPath = "$Location\assets"
        if(Test-Path $assetsPath) {
            Write-Verbose "Remove directory $assetsPath"
            rm $assetsPath -Recurse
        }

        Install-FrontendPackage -Package $package -Location $location | Out-Null

        $package.Version
    }
}

function GetDirecectoryContainingSubdir {
    param($Parent, $SubDir)
    if(Test-Path "$Parent\$SubDir") {
        $Parent
    }
    else {
        $next = Split-Path $Parent -Parent
        if($next) {
            GetDirecectoryContainingSubdir $next $SubDir
        }
    }
}
