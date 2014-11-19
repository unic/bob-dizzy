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
        $fileSystem.AddFiles($Package.GetFiles(), $Location)
    }
}
