# PowerShell helper to initialize the repo and push to GitHub.

$repoDir = Get-Location

if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..."
    git init
}

Write-Host "Adding files..."
git add .

Write-Host "Configuring git user..."
git config user.name "Your Name"
git config user.email "you@example.com"

Write-Host "Creating initial commit..."
git commit -m "Initial commit: Kays Modern Appartments demo" 2>$null

Write-Host "Setting branch to main..."
git branch -M main

$ghRepo = 'zedek2301/kays-modern-appartments'
$ghUrl = "https://github.com/$ghRepo"

if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "Found gh CLI. Creating repo and pushing..."
    gh repo create $ghRepo --public --source=. --remote=origin --push --confirm
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Success! Repository created and pushed: $ghUrl"
    }
    else {
        Write-Host "gh command returned an error. Check the output above."
    }
}
else {
    Write-Host ""
    Write-Host "gh CLI not found. Create the repo manually and then run:"
    Write-Host ""
    Write-Host "git remote add origin $ghUrl.git"
    Write-Host "git push -u origin main"
    Write-Host ""
}
