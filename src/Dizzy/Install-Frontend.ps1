function Install-Frontend
{
    [CmdletBinding()]
    Param(
        [string] $Name,
        [string] $ProjectPath,
        [string] $Branch
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

        if(-not $branch) {
            $repo = New-Object LibGit2Sharp.Repository $repoDir
            $branch = $repo.Head.Name
            if($branch -eq "(no branch)") {
                Write-Error "HEAD is detached. Please ensure you are on a valid branch or provide the 'Branch' parameter."
            }
        }

        $packageId = $config.FrontendPackage
        if(-not $packageId) {
            Write-Error "Fontend package id could not be found. Make sure Bob.config contains the FrontendPackage key."
        }

        $source = $config.NuGetFeed
        if(-not $source) {
            Write-Error "Source for Frontend package could not be found. Make sure Bob.config contains the NuGetFeed key."
        }

        $package = Get-FrontendPackage -Branch $Branch -PackageId $PackageId -Source $Source -Prerelease $Name
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
