$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")

Import-Module "$here\Dizzy" -Force

$metadataJson = "TestDrive:\metadata.json"

Describe "Get-PackageVersion" {
  Context "When providing the develop branch" {
    @{"build-branch" = "develop"; "build-version" = "30"} | ConvertTo-Json | Out-File -Encoding UTF8 $metadataJson

    $version = Get-PackageVersion -Branch "build-develop" -MetaDataJsonPath $metadataJson -MajorMinorPatch "0.3.2"

    It "Should be a develop prerelase. " {
      $version | Should Be "0.3.2-develop0030"
    }
  }
  Context "When providing the release branch" {
    @{"build-branch" = "releases/v0.14.0"; "build-version" = "30"} | ConvertTo-Json | Out-File -Encoding UTF8 $metadataJson

    $version = Get-PackageVersion -Branch "build-release" -MetaDataJsonPath $metadataJson -MajorMinorPatch "0.2.10"

    It "Should be a release prerelase. " {
      $version | Should Be "0.2.10-release0030"
    }
  }
  Context "When providing the feature branch" {
    @{"build-branch" = "feature/POSTWEPP-1908_Fancybox_improvements"; "build-version" = "30"} | ConvertTo-Json | Out-File -Encoding UTF8 $metadataJson

    $version = Get-PackageVersion -Branch "build-feature" -MetaDataJsonPath $metadataJson -MajorMinorPatch "0.1"

    It "Should be a release prerelase. " {
      $version | Should Be "0.1-POSTWEPP-1908_F-0030"
    }
  }
}
