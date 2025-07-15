# Manual GitHub Upload Script
# Run this after creating the repository manually on GitHub

Write-Host "🚀 Manual GitHub Upload Process" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

Write-Host "📋 Step 1: Create Repository on GitHub" -ForegroundColor Yellow
Write-Host "1. Go to https://github.com/new" -ForegroundColor White
Write-Host "2. Repository name: yoonjae26" -ForegroundColor White
Write-Host "3. Set to Public ✅" -ForegroundColor White
Write-Host "4. DON'T add README (we have one) ❌" -ForegroundColor White
Write-Host "5. Click 'Create repository'" -ForegroundColor White
Write-Host ""

$userInput = Read-Host "Have you created the repository? (y/n)"
if ($userInput -eq 'y' -or $userInput -eq 'Y') {
    Write-Host "✅ Proceeding with upload..." -ForegroundColor Green
    
    Write-Host "🔗 Adding remote origin..." -ForegroundColor Yellow
    git remote add origin https://github.com/yoonjae26/yoonjae26.git 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "⚠️ Remote origin might already exist, updating..." -ForegroundColor Yellow
        git remote set-url origin https://github.com/yoonjae26/yoonjae26.git
    }
    
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
        Write-Host "2. Enable GitHub Actions in repository settings" -ForegroundColor White
        Write-Host "3. Wait for snake animation to generate" -ForegroundColor White
        Write-Host "4. GitHub stats will populate within 24 hours" -ForegroundColor White
        Write-Host "5. Add a professional profile picture" -ForegroundColor White
    } else {
        Write-Host "❌ Upload failed:" -ForegroundColor Red
        Write-Host $pushResult -ForegroundColor Gray
        Write-Host ""
        Write-Host "🔧 Try these manual commands:" -ForegroundColor Yellow
        Write-Host "git remote add origin https://github.com/yoonjae26/yoonjae26.git" -ForegroundColor Gray
        Write-Host "git push -u origin main" -ForegroundColor Gray
    }
} else {
    Write-Host "❌ Please create the repository first, then run this script again." -ForegroundColor Red
}

Write-Host ""
Write-Host "🔗 Useful Links:" -ForegroundColor Cyan
Write-Host "• Your Profile: https://github.com/yoonjae26" -ForegroundColor Blue
Write-Host "• Repository: https://github.com/yoonjae26/yoonjae26" -ForegroundColor Blue
