# GitHub Repository Creation and Upload Script
# This script automates the repository creation and upload process

Write-Host "🚀 GitHub Profile Repository Upload Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Check if GitHub CLI is installed
$ghInstalled = Get-Command gh -ErrorAction SilentlyContinue
if (-not $ghInstalled) {
    Write-Host "❌ GitHub CLI (gh) is not installed!" -ForegroundColor Red
    Write-Host "Please install GitHub CLI first:" -ForegroundColor Yellow
    Write-Host "1. Go to https://cli.github.com/" -ForegroundColor Yellow
    Write-Host "2. Download and install GitHub CLI" -ForegroundColor Yellow
    Write-Host "3. Run 'gh auth login' to authenticate" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternative: Manual Repository Creation" -ForegroundColor Cyan
    Write-Host "1. Go to https://github.com/new" -ForegroundColor White
    Write-Host "2. Create repository named 'yoonjae26'" -ForegroundColor White
    Write-Host "3. Set to Public" -ForegroundColor White
    Write-Host "4. Don't add README (we have one)" -ForegroundColor White
    Write-Host "5. Click 'Create repository'" -ForegroundColor White
    Write-Host ""
    Write-Host "Then run the manual upload commands:" -ForegroundColor Yellow
    Write-Host "git remote add origin https://github.com/yoonjae26/yoonjae26.git" -ForegroundColor Gray
    Write-Host "git push -u origin main" -ForegroundColor Gray
    exit 1
}

# Check if user is authenticated
$authStatus = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not authenticated with GitHub!" -ForegroundColor Red
    Write-Host "Please run: gh auth login" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ GitHub CLI is installed and authenticated" -ForegroundColor Green

# Create repository
Write-Host "📁 Creating repository 'yoonjae26'..." -ForegroundColor Yellow
$createResult = gh repo create yoonjae26 --public --description "AI Developer & ML Engineer | Specializing in NLP, Voice Technology, and Computer Vision" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Repository created successfully!" -ForegroundColor Green
} else {
    Write-Host "⚠️ Repository might already exist or creation failed:" -ForegroundColor Yellow
    Write-Host $createResult -ForegroundColor Gray
}

# Add remote origin
Write-Host "🔗 Adding remote origin..." -ForegroundColor Yellow
git remote add origin https://github.com/yoonjae26/yoonjae26.git 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Remote origin might already exist, updating..." -ForegroundColor Yellow
    git remote set-url origin https://github.com/yoonjae26/yoonjae26.git
}

# Push to GitHub
Write-Host "🚀 Uploading to GitHub..." -ForegroundColor Yellow
$pushResult = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Successfully uploaded to GitHub!" -ForegroundColor Green
    Write-Host ""
    Write-Host "🎉 Your profile is now live at:" -ForegroundColor Cyan
    Write-Host "https://github.com/yoonjae26" -ForegroundColor Blue
    Write-Host ""
    Write-Host "📋 Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Visit your profile to see the new README" -ForegroundColor White
    Write-Host "2. GitHub Actions will generate snake animation (may take a few minutes)" -ForegroundColor White
    Write-Host "3. GitHub stats will populate within 24 hours" -ForegroundColor White
    Write-Host "4. Consider adding a profile picture" -ForegroundColor White
    Write-Host "5. Update your bio in GitHub profile settings" -ForegroundColor White
} else {
    Write-Host "❌ Upload failed:" -ForegroundColor Red
    Write-Host $pushResult -ForegroundColor Gray
    Write-Host ""
    Write-Host "🔧 Manual upload commands:" -ForegroundColor Yellow
    Write-Host "git remote add origin https://github.com/yoonjae26/yoonjae26.git" -ForegroundColor Gray
    Write-Host "git push -u origin main" -ForegroundColor Gray
}

Write-Host ""
Write-Host "🔗 Useful Links:" -ForegroundColor Cyan
Write-Host "• Your Profile: https://github.com/yoonjae26" -ForegroundColor Blue
Write-Host "• Repository: https://github.com/yoonjae26/yoonjae26" -ForegroundColor Blue
Write-Host "• GitHub Actions: https://github.com/yoonjae26/yoonjae26/actions" -ForegroundColor Blue
