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
      [string] $Prerelease
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

    $pattern =  & {
        if($Prerelease) {
            "*-$Prerelease-????"
        }
        else {
            switch -wildcard ($branch) {
                "releases/*" {
                    "*-release????"
                }
                "hotfix/*" {
                    "*-release????"
                }
                default {
                    "*-develop????"
                }
            }
        }
    }

    $packages | sort {$_.Version} | where {$_.Version -like $pattern} |  select -Last 1
  }
}
