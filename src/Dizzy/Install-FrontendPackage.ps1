<#
.SYNOPSIS
Installs a Frontend NuGet package to a specific location.

.DESCRIPTION
Installs the specified Frontend NuGet package to the specified location.

.PARAMETER Package
The NuGet package to install.

.PARAMETER Location
The location where the Frontend NuGet package should be installed.

.EXAMPLE

#>
function Install-FrontendPackage
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [NuGet.IPackage] $Package,
        [Parameter(Mandatory=$true)]
        [string] $Location
        )
    Process
    {
        Write-Verbose "Copy  files to $Location"
        $fileSystem = New-Object NuGet.PhysicalFileSystem $Location
        $package.GetFiles().Path | % {"$Location\$_"} | ? {Test-Path $_} | % {rm $_}
        $fileSystem.AddFiles($Package.GetFiles(), $Location)
    }
}
