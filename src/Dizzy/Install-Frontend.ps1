<#
.SYNOPSIS
[Deprecated] Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)
Installs locally the correct frontend package depending on context.

.DESCRIPTION
[Deprecated] Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)
Installs the newest frontend package. By default it installs the frontend to the WebRoot. It is possible to install frontend to the custom directory by setting the relative path with FrontendOutputDirectoryPath node in Bob.config.

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
        Write-Warning "Install-Frontend is deprecated since Dizzy 3.0. Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)"
        Invoke-BobCommand {

        $config = Get-ScProjectConfig $ProjectPath
        $webPath = $config.WebRoot
        
        if(-not $webPath) {
            Write-Error "Web path is not configured."
        }
        
        if ($config.FrontendOutputDirectoryPath) {
            
            if (Test-Path (Join-Path $webPath $config.FrontendOutputDirectoryPath)) {
                
                $Location = Join-Path $webPath $config.FrontendOutputDirectoryPath
                
            }
            else {
                
                mkdir (Join-Path $webPath $config.FrontendOutputDirectoryPath) | Out-Null
                
                $Location = Join-Path $webPath $config.FrontendOutputDirectoryPath                
            }
        }
        
        if (-not $Location) {
            
            $Location = "$($config.GlobalWebPath)\$($config.WebsiteCodeName)\$($config.WebFolderName)"
            
        }
        
        if(-not $Location) {
            Write-Error "No Location could be found to extract."
        }

        $website = Resolve-Path $config.WebsitePath
        $repoDir = GetDirecectoryContainingSubdir $website ".git"
        if(-not $repoDir) {
            Write-Error "$website does not contain a git repository."
        }

        $repo = New-Object LibGit2Sharp.Repository $repoDir, $null

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

        Write-Verbose "Found the following situation:"
        Write-Verbose "    Current Branch on repository: $Branch"
        Write-Verbose "    Frontend package id:          $PackageId"
        Write-Verbose "    Package source:               $Source"
        Write-Verbose "    Package name:                 $Name"
        Write-Verbose "    Package Version:              $Version"
        Write-Verbose "Search corresponding Frontend package..."
        
        $package = Get-FrontendPackage -Branch $Branch -PackageId $PackageId -Source $Source -Prerelease $Name -Version $Version -ProjectPath $ProjectPath
        if(-not $package) {
            Write-Error "Frontend package from branch $Branch with the ID $PackageId in $Source could not be found."
        }

        if(-not (Test-Path $Location )) {
            Write-Verbose "Create directory $Location"
            mkdir $Location | Out-Null
        }
        
        Install-FrontendPackage -Package $package -Location $location| Out-Null

        Write-Verbose "Installed package $($package.Version)"
    }
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
