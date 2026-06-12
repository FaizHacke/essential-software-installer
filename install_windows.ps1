
```powershell
#!/usr/bin/env pwsh
# Essential Software Installer for Windows
# Run this script as Administrator

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Essential Software Installer for Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: This script must be run as Administrator!" -ForegroundColor Red
    Write-Host "Right-click on PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    exit 1
}

# Check if winget is available
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: winget not found. Please install App Installer from Microsoft Store." -ForegroundColor Red
    exit 1
}

Write-Host "Installing essential software... This may take a few minutes." -ForegroundColor Green
Write-Host ""

# Define software list
$software = @(
    @{Name="Microsoft PowerToys"; Id="Microsoft.PowerToys"},
    @{Name="Everything"; Id="voidtools.Everything"},
    @{Name="7-Zip"; Id="7zip.7zip"},
    @{Name="Firefox"; Id="Mozilla.Firefox"},
    @{Name="Discord"; Id="Discord.Discord"},
    @{Name="Telegram"; Id="Telegram.TelegramDesktop"},
    @{Name="Git"; Id="Git.Git"},
    @{Name="Visual Studio Code"; Id="Microsoft.VisualStudioCode"},
    @{Name="Docker Desktop"; Id="Docker.DockerDesktop"},
    @{Name="VLC Media Player"; Id="VideoLAN.VLC"},
    @{Name="GIMP"; Id="GIMP.GIMP"},
    @{Name="OBS Studio"; Id="OBSProject.OBSStudio"},
    @{Name="LibreOffice"; Id="TheDocumentFoundation.LibreOffice"},
    @{Name="Bitwarden"; Id="Bitwarden.Bitwarden"},
    @{Name="FileZilla"; Id="FileZilla.FileZillaClient"},
    @{Name="Microsoft PC Manager"; Id="Microsoft.PCManager"}
)

$total = $software.Count
$current = 0

foreach ($app in $software) {
    $current++
    Write-Host "[$current/$total] Installing $($app.Name)..." -ForegroundColor Yellow
    try {
        winget install --id $app.Id -e --accept-package-agreements --accept-source-agreements --silent
        Write-Host "✓ $($app.Name) installed successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ Failed to install $($app.Name)" -ForegroundColor Red
    }
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Installation Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Some apps may require a system restart to work properly." -ForegroundColor Yellow
Read-Host "Press Enter to exit"
