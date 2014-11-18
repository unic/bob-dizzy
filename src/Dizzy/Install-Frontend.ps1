function Install-Frontend
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string] $Branch,
        [Parameter(Mandatory=$true)]
        [string] $PackageId,
        [Parameter(Mandatory=$true)]
        [string] $Source,
        [string] $Location,
        [string] $Name
    )
    Process
    {
        if(-not $Location) {
            $config = Get-ScProjectConfig
            if($config.WebsitePath) {
                $Location = $config.WebsitePath
            }
        }
        if(-not $Location) {
            Write-Error "No Location could be found to extract."
        }

        $package = Get-FrontendPackage -Branch $Branch -PackageId $PackageId -Source $Source -Prerelease $Name
        if(-not $package) {
            "Frontend package form branch $Branch with the ID $PackageId in $Source could not be found."
        }

        if(-not (Test-Path $Location )) {
            mkdir $Location | Out-Null
        }
        $assetsPath = "$Location\assets"
        if(Test-Path $assetsPath) {
            rm $assetsPath -Recurse
        }

        $fileSystem = New-Object NuGet.PhysicalFileSystem $Location
        $fileSystem.AddFiles($package.GetFiles(), $Location)
        $package.Version
    }
}
