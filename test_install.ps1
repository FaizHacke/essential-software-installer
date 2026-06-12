# test_install.ps1 - Just installs 7-Zip
Write-Host "Testing installation of 7-Zip..." -ForegroundColor Cyan

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run PowerShell as Administrator!" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    pause
    exit 1
}

# Install just 7-Zip
Write-Host "Installing 7-Zip..." -ForegroundColor Yellow
winget install --id 7zip.7zip -e --accept-package-agreements --silent

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 7-Zip installed successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Installation failed" -ForegroundColor Red
}

Write-Host ""
Write-Host "Test complete! Press any key to exit..."
pause
