# UTF-8 encoding setup
$OutputEncoding = [Console]::OutputEncoding = [Console]::InputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# Get-SystemInfo-KR.ps1
# Windows system information collection script (Korean)

Write-Host "=== ?쒖뒪???뺣낫 ?섏쭛 以?.. ===" -ForegroundColor Cyan
Write-Host ""

# Array to store output
$output = @()
$output += "=== ?쒖뒪???뺣낫 由ы룷??==="
$output += "?앹꽦 ?쒓컙: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$output += ""

# 1. OS Version
Write-Host "[1/5] OS 踰꾩쟾 ?뺤씤..." -ForegroundColor Yellow
$osInfo = Get-CimInstance Win32_OperatingSystem
$osVersion = "$($osInfo.Caption) (鍮뚮뱶 $($osInfo.BuildNumber))"
$output += "OS 踰꾩쟾: $osVersion"
Write-Host "  -> $osVersion" -ForegroundColor Green

# 2. PowerShell Version
Write-Host "[2/5] PowerShell 踰꾩쟾 ?뺤씤..." -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion.ToString()
$output += "PowerShell 踰꾩쟾: $psVersion"
Write-Host "  -> $psVersion" -ForegroundColor Green

# 3. Git Version
Write-Host "[3/5] Git ?ㅼ튂 ?뺤씤..." -ForegroundColor Yellow
try {
    $gitVersion = (git --version 2>$null)
    $output += "Git: $gitVersion"
    Write-Host "  -> $gitVersion" -ForegroundColor Green
} catch {
    $output += "Git: ?ㅼ튂?섏? ?딆쓬"
    Write-Host "  -> Git???ㅼ튂?섏? ?딆븯?듬땲?? -ForegroundColor Red
}

# 4. Current Directory
Write-Host "[4/5] ?묒뾽 ?붾젆?곕━ ?뺤씤..." -ForegroundColor Yellow
$currentDir = (Get-Location).Path
$output += "?꾩옱 ?붾젆?곕━: $currentDir"
Write-Host "  -> $currentDir" -ForegroundColor Green

# 5. Disk Free Space
Write-Host "[5/5] ?붿뒪???ъ쑀 怨듦컙 ?뺤씤..." -ForegroundColor Yellow
$disk = Get-PSDrive C
$freeSpaceGB = [math]::Round($disk.Free / 1GB, 2)
$totalSpaceGB = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
$usedPercent = [math]::Round(($disk.Used / ($disk.Used + $disk.Free)) * 100, 1)
$diskInfo = "$freeSpaceGB GB ?⑥쓬 / $totalSpaceGB GB (?ъ슜瑜? $usedPercent%)"
$output += "?붿뒪??怨듦컙 (C:): $diskInfo"
Write-Host "  -> $diskInfo" -ForegroundColor Green

# Save to file
Write-Host ""
Write-Host "寃곌낵瑜?system-info-kr.txt?????以?.." -ForegroundColor Cyan
$output += ""
$output += "=== 由ы룷????==="

# Save as UTF-8 with BOM
$utf8Bom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllLines("$PWD\system-info-kr.txt", $output, $utf8Bom)

Write-Host "?꾨즺! system-info-kr.txt ?뚯씪???앹꽦?섏뿀?듬땲??" -ForegroundColor Green
Write-Host ""
Write-Host "李멸퀬: ???ㅽ겕由쏀듃???먮룞?쇰줈 UTF-8 ?몄퐫?⑹쓣 ?ㅼ젙?⑸땲??" -ForegroundColor Gray