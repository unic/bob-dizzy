$Invocation = (Get-Variable MyInvocation -Scope 0).Value
$PSScriptRoot = Split-Path $Invocation.MyCommand.Path

$paketFolder = "$PSScriptRoot\.paket"
$paketBoot = "$paketFolder\paket.bootstrapper.exe"

& $paketBoot
& "$paketFolder\paket.exe" restore "0.12.2"

if($LASTEXITCODE -ne 0) {
    if($env:TEAMCITY_VERSION) {
        exit 1
    }
}
