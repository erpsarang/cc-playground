$content = @'
# UTF-8 encoding setup
$OutputEncoding = [Console]::OutputEncoding = [Console]::InputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# Get-SystemInfo-KR.ps1
# Windows system information collection script (Korean)

Write-Host "=== 시스템 정보 수집 중... ===" -ForegroundColor Cyan
Write-Host ""

# Array to store output
$output = @()
$output += "=== 시스템 정보 리포트 ==="
$output += "생성 시간: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$output += ""

# 1. OS Version
Write-Host "[1/5] OS 버전 확인..." -ForegroundColor Yellow
$osInfo = Get-CimInstance Win32_OperatingSystem
$osVersion = "$($osInfo.Caption) (빌드 $($osInfo.BuildNumber))"
$output += "OS 버전: $osVersion"
Write-Host "  -> $osVersion" -ForegroundColor Green

# 2. PowerShell Version
Write-Host "[2/5] PowerShell 버전 확인..." -ForegroundColor Yellow
$psVersion = $PSVersionTable.PSVersion.ToString()
$output += "PowerShell 버전: $psVersion"
Write-Host "  -> $psVersion" -ForegroundColor Green

# 3. Git Version
Write-Host "[3/5] Git 설치 확인..." -ForegroundColor Yellow
try {
    $gitVersion = (git --version 2>$null)
    $output += "Git: $gitVersion"
    Write-Host "  -> $gitVersion" -ForegroundColor Green
} catch {
    $output += "Git: 설치되지 않음"
    Write-Host "  -> Git이 설치되지 않았습니다" -ForegroundColor Red
}

# 4. Current Directory
Write-Host "[4/5] 작업 디렉터리 확인..." -ForegroundColor Yellow
$currentDir = (Get-Location).Path
$output += "현재 디렉터리: $currentDir"
Write-Host "  -> $currentDir" -ForegroundColor Green

# 5. Disk Free Space
Write-Host "[5/5] 디스크 여유 공간 확인..." -ForegroundColor Yellow
$disk = Get-PSDrive C
$freeSpaceGB = [math]::Round($disk.Free / 1GB, 2)
$totalSpaceGB = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
$usedPercent = [math]::Round(($disk.Used / ($disk.Used + $disk.Free)) * 100, 1)
$diskInfo = "$freeSpaceGB GB 남음 / $totalSpaceGB GB (사용률: $usedPercent%)"
$output += "디스크 공간 (C:): $diskInfo"
Write-Host "  -> $diskInfo" -ForegroundColor Green

# Save to file
Write-Host ""
Write-Host "결과를 system-info-kr.txt에 저장 중..." -ForegroundColor Cyan
$output += ""
$output += "=== 리포트 끝 ==="

# Save as UTF-8 with BOM
$utf8Bom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllLines("$PWD\system-info-kr.txt", $output, $utf8Bom)

Write-Host "완료! system-info-kr.txt 파일이 생성되었습니다." -ForegroundColor Green
Write-Host ""
Write-Host "참고: 이 스크립트는 자동으로 UTF-8 인코딩을 설정합니다." -ForegroundColor Gray
'@

# Save as UTF-8 with BOM
$utf8Bom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText("$PWD\Get-SystemInfo-KR.ps1", $content, $utf8Bom)
Write-Host "Get-SystemInfo-KR.ps1 created with UTF-8 BOM encoding"
