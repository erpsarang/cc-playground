# Get-SystemInfo.ps1
# Windows system information collection script

Write-Host "=== Collecting System Information... ===" -ForegroundColor Cyan
Write-Host ""

# Array to store output
$output = @()
$output += "=== System Information Report ==="
$output += "Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$output += ""

# 1. OS Version
Write-Host "[1/5] Checking OS version..." -ForegroundColor Yellow
$osInfo = Get-CimInstance Win32_OperatingSystem
$osVersion = "$($osInfo.Caption) (Build $($osInfo.BuildNumber))"
$output += "OS Version: $osVersion"
Write-Host "  -> $osVersion" -ForegroundColor Green

# 2. PowerShell Version
Write-Host "[2/5] Checking PowerShell version..." -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion.ToString()
$output += "PowerShell Version: $psVersion"
Write-Host "  -> $psVersion" -ForegroundColor Green

# 3. Git Version (check installation)
Write-Host "[3/5] Checking Git installation..." -ForegroundColor Yellow
try {
    $gitVersion = (git --version 2>$null)
    $output += "Git: $gitVersion"
    Write-Host "  -> $gitVersion" -ForegroundColor Green
} catch {
    $output += "Git: NOT INSTALLED"
    Write-Host "  -> Git is not installed" -ForegroundColor Red
}

# 4. Current Working Directory
Write-Host "[4/5] Checking working directory..." -ForegroundColor Yellow
$currentDir = (Get-Location).Path
$output += "Current Directory: $currentDir"
Write-Host "  -> $currentDir" -ForegroundColor Green

# 5. Disk Free Space (C drive)
Write-Host "[5/5] Checking disk free space..." -ForegroundColor Yellow
$disk = Get-PSDrive C
$freeSpaceGB = [math]::Round($disk.Free / 1GB, 2)
$totalSpaceGB = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
$diskInfo = "$freeSpaceGB GB free of $totalSpaceGB GB"
$output += "Disk Space (C:): $diskInfo"
Write-Host "  -> $diskInfo" -ForegroundColor Green

# Save results to file
Write-Host ""
Write-Host "Saving results to system-info.txt..." -ForegroundColor Cyan
$output += ""
$output += "=== End of Report ==="

$output | Out-File -FilePath "system-info.txt" -Encoding UTF8
Write-Host "Done! system-info.txt has been created." -ForegroundColor Green
