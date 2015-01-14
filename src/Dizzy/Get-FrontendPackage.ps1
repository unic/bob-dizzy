<#
.SYNOPSIS
Gets a frontend package for the coresponding backend branch.

.DESCRIPTION
Gets a frontend package for the coresponding backend branch
with optionally a specific version and specific prerelase tag.
For more information about the exact algorithm check the dizzy docs.

.PARAMETER Branch
The name of the backend branch.

.PARAMETER PackageId
The NuGet id of the frontend package to download.

.PARAMETER Source
The NuGet feed url to use to search the package.

.PARAMETER Prerelease
If the Prerelease parameter is specified, this one will be taken instead of "develop" or "release"

.PARAMETER Version
The version without prerelease to use.

.EXAMPLE
Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed

.EXAMPLE
Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed  -Version 0.1

.EXAMPLE
Get-FrontendPackage -Branch develop -PackageId Cust.Frontend -Source http://my-nuget.org/feed  -Prerelease myFeatureBranch

#>
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
