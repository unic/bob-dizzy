$Invocation = (Get-Variable MyInvocation -Scope 0).Value
$PSScriptRoot = Split-Path $Invocation.MyCommand.Path

$paketFolder = "$PSScriptRoot\.paket"
$paketBoot = "$paketFolder\paket.bootstrapper.exe"

& $paketBoot --prefer-nuget
& "$paketFolder\paket.exe" restore

if($LASTEXITCODE -ne 0) {
    if($env:TEAMCITY_VERSION) {
        exit 1
    }
}
