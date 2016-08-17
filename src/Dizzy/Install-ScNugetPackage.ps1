<#
.SYNOPSIS
Installs locally the correct frontend package depending on context.

.DESCRIPTION
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

function Install-ScNugetPackage {
    param(
        [string[]] $NugetPackage,
        [string] $OutputDirectory,
        [string] $ProjectPath
    )

    process {
         function GetPackageVersion {
            param($packageId, $source, $config)

            $repoContext = GetRepoContext $config
            $version = $repoContext.version

            $releasePattern = "release????"

            $pattern =  & {
                $branch = $repoContext.branch -replace "refs/heads/", ""
                switch -wildcard ($branch) {
                    "release/*" {
                        "$version-$releasePattern"
                    }
                    "hotfix/*" {
                        "$version-$releasePattern"
                    }
                    default {
                        "$version-develop????"
                    }
                }
            }
            
            return $pattern,  "*-$releasePattern"
        }


        function GetRepoContext {
            param($config)
            $website = Resolve-Path $config.WebsitePath
            $repoDir = GetDirecectoryContainingSubdir $website ".git"
            if(-not $repoDir) {
                Write-Error "$website does not contain a git repository."
            }

            $repo = New-Object LibGit2Sharp.Repository $repoDir, $null

            $branch = $repo.Head.Name
            if($branch -eq "(no branch)") {
                Write-Error "HEAD is detached. Please ensure you are on a valid branch or provide the 'Branch' parameter."
            }

            [GitVersion.Logger]::WriteInfo = {}
            [GitVersion.Logger]::WriteWarning = {}
            [GitVersion.Logger]::WriteError = {}

            $gitVersionConfig = New-Object GitVersion.Config
            $ctx = New-Object GitVersion.GitVersionContext $repo, $gitVersionConfig
            $versionFinder = New-Object GitVersion.GitVersionFinder
            $version = $versionFinder.FindVersion($ctx).ToString("j")

            Write-Verbose "Found the following situation:"
            Write-Verbose "    Current Branch on repository: $Branch"
            Write-Verbose "    Version of repository:  $Version"

            return @{
                "branch" = $branch
                "version" = $version
            }

        }

        function GetNugetPackage {
            param($packageId, $versionPatterns, $source)

            $packages = Get-NugetPackage -PackageId $packageId -ProjectPath $ProjectPath -Source $source

            foreach($pattern in $versionPatterns) {
                $possiblePackage =  $packages | where {$_.Version -like $pattern} |  select -Last 1
                if($possiblePackage) {
                    return $possiblePackage
                }            
            }
        }


        
        Invoke-BobCommand {

        $config = Get-ScProjectConfig $ProjectPath

        if(-not $OutputDirectory) {
            $OutputDirectory = $config.WebRoot
        }

        $packages = $config.NugetPackages
        foreach($package in $packages) {
            if($NugetPackage -and -not $NugetPackage.Contains($package.ID)) {
                # If the NugetPackage was specified, we only want to install the specified packages.  
                continue;
            }

            $versionPatterns = $package.Version
            if(-not $versionPatterns) {
                $versionPatterns = GetPackageVersion $package.ID $config.NuGetFeed $config
            }
            
            Write-Verbose "Try to find newest package with version pattern $([string]::Join(", ", $versionPatterns))"

            $nugetPackageToInstall = GetNugetPackage $package.ID $versionPatterns $config.NuGetFeed

            if($package.Target) {
                $location = Join-Path $OutputDirectory $package.Target
            }
            else {
                $location = $OutputDirectory
            }


            Install-FrontendPackage -Package $nugetPackageToInstall -Location $location | Out-Null
        }
        }
    }
       
}