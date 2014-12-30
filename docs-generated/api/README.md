# dizzy - API

##  Get-BackendBranch
Gets a backend branch based on a frontend branch by querying Stash.    
    
    Get-BackendBranch [-FrontendBranch] <String> [-StashUrl] <String> [-Project] <String> [-Repo] <String> [-UserName] <String> [-Password] <SecureString> [<CommonParameters>]


 [Read more](Get-BackendBranch.md)
##  Get-FrontendPackage
    Get-FrontendPackage [-Branch] <string> [-PackageId] <string> [-Source] <string> [[-Prerelease] <string>] [[-Version] <string>] [<CommonParameters>]


 [Read more](Get-FrontendPackage.md)
##  Get-PackageVersion
    Get-PackageVersion [-Branch] <string> [-MetaDataJsonPath] <string> [-MajorMinorPatch] <string> [<CommonParameters>]


 [Read more](Get-PackageVersion.md)
##  GetDirecectoryContainingSubdir
    GetDirecectoryContainingSubdir [[-Parent] <Object>] [[-SubDir] <Object>]


 [Read more](GetDirecectoryContainingSubdir.md)
##  Install-Frontend
    Install-Frontend [[-Name] <string>] [[-ProjectPath] <string>] [[-Branch] <string>] [[-Version] <string>] [<CommonParameters>]


 [Read more](Install-Frontend.md)
##  Install-FrontendPackage
    Install-FrontendPackage [-Package] <IPackage> [-Location] <string> [<CommonParameters>]


 [Read more](Install-FrontendPackage.md)
##  ResolvePath
    ResolvePath [[-PackageId] <Object>] [[-RelativePath] <Object>]


 [Read more](ResolvePath.md)
##  Set-TeamcityVariable
    Set-TeamcityVariable [-Key] <string> [[-Value] <string>] [<CommonParameters>]


 [Read more](Set-TeamcityVariable.md)
##  Set-TeamcityVariablesFromMetadata
    Set-TeamcityVariablesFromMetadata [-MetaDataJsonPath] <string> [<CommonParameters>]


 [Read more](Set-TeamcityVariablesFromMetadata.md)
##  Start-TeamcityBuild
    Start-TeamcityBuild [-BuildId] <string> [-Url] <string> [-User] <string> [-Password] <string> [-Branch] <string> [<CommonParameters>]


 [Read more](Start-TeamcityBuild.md)
##  Write-FrontendPackage
    Write-FrontendPackage [-Version] <string> [-Id] <string> [-Path] <string> [-OutputLocation] <string> [<CommonParameters>]


 [Read more](Write-FrontendPackage.md)

