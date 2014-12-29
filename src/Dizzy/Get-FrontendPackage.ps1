function Get-FrontendPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Branch,
        [Parameter(Mandatory=$true)]
        [string]$PackageId,
        [Parameter(Mandatory=$true)]
        [string]$Source,
        [string] $Prerelease,
        [string] $Version = "*"
    )
    Process
    {
        $fs = New-Object NuGet.PhysicalFileSystem $pwd
        $setting = [NuGet.Settings]::LoadDefaultSettings($fs,  [NullString]::Value, $null);
        $sourceProvider = New-Object NuGet.PackageSourceProvider $setting

        $credentialProvider = New-Object NuGet.SettingsCredentialProvider -ArgumentList ([NuGet.ICredentialProvider][NuGet.NullCredentialProvider]::Instance), ([NuGet.IPackageSourceProvider]$sourceProvider)

        [NuGet.HttpClient]::DefaultCredentialProvider = $credentialProvider

        $repo = New-Object  NuGet.DataServicePackageRepository $Source

        $packages = $repo.FindPackagesById($PackageId)

        $releasePattern = "release????"

        $pattern =  & {
            if($Prerelease) {
                "*-$Prerelease-????"
            }
            else {
                $Branch = $Branch -replace "refs/heads/", ""
                switch -wildcard ($branch) {
                    "release/*" {
                        "$Version-$releasePattern"
                    }
                    "hotfix/*" {
                        "$Version-$releasePattern"
                    }
                    default {
                        "$Version-develop????"
                    }
                }
            }
        }

        $package = $packages | where {$_.Version -like $pattern} |  select -Last 1
        if(-not $package) {
            $packages | where {$_.Version -like "*-$releasePattern"} |  select -Last 1
        }
        else {
            $package
        }
    }
}
