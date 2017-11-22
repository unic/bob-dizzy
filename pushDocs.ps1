param([string]$buildFolder, [string]$docSource, [string]$repoUrl)

$workingDir = "$($buildFolder)\..\gh-pages"
$workingBranch = "gh-pages"

Push-Location

if (Test-Path("$($workingDir)")) {
    Remove-Item "$($workingDir)" -Recurse -Force
}
mkdir $workingDir

git clone --quiet --branch=$workingBranch "$($repoUrl)" "$($workingDir)"
cd $($workingDir)
git status

Get-ChildItem -Attributes !r | Remove-Item -Recurse -Force
Copy-Item -Path "$($buildFolder)\$($docSource)\**" -Destination $pwd.Path -Recurse
git status

$thereAreChanges = git status | select-string -pattern "Changes not staged for commit:","Untracked files:" -simplematch
if ($thereAreChanges -ne $null) { 
    Write-Host "Committing changes to docs..."
    git add --all
    git status
    git commit -m "CI build"
    git status
    git push -q
    Write-Host "Changes pushed succesfully" -ForegroundColor Green
}
else { 
    Write-Host "No changes to documentation to commit" -ForegroundColor Blue
}
Pop-Location