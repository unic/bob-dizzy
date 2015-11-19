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
        Write-Verbose "Install frontend to $Location"
        Install-NugetPackage -Package $Package -OutputLocation $Location -RemoveFiles $true
    }
}
