<#
.SYNOPSIS
Installs all configure NuGet packages to the webroot or to the specified path.


.DESCRIPTION
Installs all NuGet packages which are configured in the Bob.config
either to the web-root or to the specified directory.

.PARAMETER NugetPackage
If the `NugetPackage` parameter is specified only the this packages wil be installed.
If nothing is specified all packages will be installed.

.PARAMETER OutputDirectory
The directory where the packages will be extracted. 
If nothing is specified, the packages will be installed to the web-root. 

.PARAMETER ProjectPath
The path to the website project. If it's not specified, the current Visual Studio website project will be used.

.EXAMPLE
Install-ScNugetPackage

.EXAMPLE
Install-ScNugetPackage Customer.Frontend

.EXAMPLE
Install-ScNugetPackage -OutputDirecoty D:\work\project\packing

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

            Write-Verbose "        Current Branch on repository: $Branch"
            Write-Verbose "        Version of repository:  $Version"

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

        if($NugetPackage) {
            $NugetPackage = $NugetPackage | % {$_.ToLower()}
        } 

        $packages = $config.NugetPackages
        foreach($package in $packages) {

            Write-Verbose "============"
            if($NugetPackage -and -not $NugetPackage.Contains($package.ID.ToLower())) {
                # If the NugetPackage was specified, we only want to install the specified packages.
                Write-Verbose "Skip $($package.ID)"  
                continue;
            }
            Write-Verbose "Start instalation of $($package.ID)"

            $versionPatterns = $package.Version
            if(-not $versionPatterns) {
                Write-Verbose "    No version is specified for $($package.ID). Calculate version pattern according to current context:"
                $versionPatterns = GetPackageVersion $package.ID $config.NuGetFeed $config
            }
            
            Write-Verbose "    Get newest package of $($package.ID) with version pattern $([string]::Join(", ", $versionPatterns))"

            $nugetPackageToInstall = GetNugetPackage $package.ID $versionPatterns $config.NuGetFeed
            if(-not $nugetPackageToInstall) {
                Write-Error "No package was found with ID $($package.ID) and verson pattern $($versionPatterns) on the NuGet feed $($config.NuGetFeed)"
            }
            Write-Verbose "    Found version $($nugetPackageToInstall.Version) of package $($package.ID)"

            if($package.Target) {
                $location = Join-Path $OutputDirectory $package.Target
            }
            else {
                $location = $OutputDirectory
            }

            Write-Verbose "    Start installation of package $($package.ID) $($nugetPackageToInstall.Version) to $location"
            Install-NugetPackage -Package $nugetPackageToInstall -OutputLocation $Location
            Write-Verbose "    Installed version $($package.ID) $($nugetPackageToInstall.Version) to $location"
        }
        }
    }
       
}