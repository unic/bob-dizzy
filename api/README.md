# Dizzy - API

##  Get-BackendBranch
Gets a backend branch based on a frontend branch by querying Stash.    
    
    Get-BackendBranch [-FrontendBranch] <String> [-StashUrl] <String> [-Project] <String> [-Repo] <String> [-UserName] <String> [-Password] <SecureString> [<CommonParameters>]


 [Read more](Get-BackendBranch.md)
##  Get-FrontendPackage
Gets a frontend package for the corresponding backend branch.    
    
    Get-FrontendPackage [-Branch] <String> [-PackageId] <String> [-Source] <String> [[-Prerelease] <String>] [[-Version] <String>] [[-ProjectPath] <String>] [<CommonParameters>]


 [Read more](Get-FrontendPackage.md)
##  Get-PackageVersion
Gets the version to use for building a NuGet package    
    
    Get-PackageVersion [-Branch] <String> [-MetaDataJsonPath] <String> [-MajorMinorPatch] <String> [<CommonParameters>]


 [Read more](Get-PackageVersion.md)
##  GetDirecectoryContainingSubdir
    GetDirecectoryContainingSubdir [[-Parent] <Object>] [[-SubDir] <Object>]


 [Read more](GetDirecectoryContainingSubdir.md)
##  Install-Frontend
[Deprecated] Use Install-ScNugetPackage instead (https://teamcity.unic.com/repository/download/Sitecore_Frameworks_Bob_TheBook_BuildTheBook/.lastSuccessful/Dizzy/MigrationTo30.html)
Installs locally the correct frontend package depending on context.    
    
    Install-Frontend [[-Name] <String>] [[-ProjectPath] <String>] [[-Branch] <String>] [[-Version] <String>] [<CommonParameters>]


 [Read more](Install-Frontend.md)
##  Install-FrontendPackage
Installs a Frontend NuGet package to a specific location.    
    
    Install-FrontendPackage [-Package] <IPackage> [-Location] <String> [<CommonParameters>]


 [Read more](Install-FrontendPackage.md)
##  Install-ScNugetPackage
Installs all configured NuGet packages to the webroot or to the specified path.    
    
    Install-ScNugetPackage [[-NugetPackage] <String[]>] [[-OutputDirectory] <String>] [[-ProjectPath] <String>] [<CommonParameters>]


 [Read more](Install-ScNugetPackage.md)
##  ResolvePath
    ResolvePath [[-PackageId] <Object>] [[-RelativePath] <Object>]


 [Read more](ResolvePath.md)
##  Set-TeamcityVariable
Sets the value of specific Dizzy TeamCity parameter.    
    
    Set-TeamcityVariable [-Key] <String> [[-Value] <String>] [<CommonParameters>]


 [Read more](Set-TeamcityVariable.md)
##  Set-TeamcityVariablesFromMetadata
Sets different TeamCity parameters from a specific metadata.json file.    
    
    Set-TeamcityVariablesFromMetadata [-MetaDataJsonPath] <String> [<CommonParameters>]


 [Read more](Set-TeamcityVariablesFromMetadata.md)
##  Start-TeamcityBuild
Starts a new build of a specific TeamCtiy build configuration with a specific branch.    
    
    Start-TeamcityBuild [-BuildId] <String> [-Url] <String> [-User] <String> [-Password] <String> [-Branch] <String> [<CommonParameters>]


 [Read more](Start-TeamcityBuild.md)
##  Write-FrontendPackage
Creates a new frontend NuGet package.    
    
    Write-FrontendPackage [-Version] <String> [-Id] <String> [-Path] <String> [-OutputLocation] <String> [[-Folders] <String[]>] [<CommonParameters>]


 [Read more](Write-FrontendPackage.md)

