# Get-SystemInfo-KR-v2.ps1
# Windows 시스템 정보 수집 스크립트 (한국어) - PowerShell 7용
# 실행 방법: pwsh -File Get-SystemInfo-KR-v2.ps1

Write-Host "=== 시스템 정보 수집 중... ===" -ForegroundColor Cyan
Write-Host ""

# 출력 내용을 저장할 배열
$output = @()
$output += "=== 시스템 정보 리포트 ==="
$output += "생성 시간: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$output += "PowerShell 버전: $($PSVersionTable.PSVersion)"
$output += ""

# 1. OS 버전
Write-Host "[1/6] OS 버전 확인..." -ForegroundColor Yellow
$osInfo = Get-CimInstance Win32_OperatingSystem
$osVersion = "$($osInfo.Caption) (빌드 $($osInfo.BuildNumber))"
$output += "OS 버전: $osVersion"
Write-Host "  → $osVersion" -ForegroundColor Green

# 2. PowerShell 버전 (5.x와 7.x 구분)
Write-Host "[2/6] PowerShell 환경 확인..." -ForegroundColor Yellow
$edition = $PSVersionTable.PSEdition
$version = $PSVersionTable.PSVersion.ToString()
$psInfo = "PowerShell $edition $version"
$output += "PowerShell: $psInfo"
Write-Host "  → $psInfo" -ForegroundColor Green

# 3. Git 버전
Write-Host "[3/6] Git 설치 확인..." -ForegroundColor Yellow
try {
    $gitVersion = (git --version 2>$null)
    $output += "Git: $gitVersion"
    Write-Host "  → $gitVersion" -ForegroundColor Green
} catch {
    $output += "Git: 설치되지 않음"
    Write-Host "  → Git이 설치되지 않았습니다" -ForegroundColor Red
}

# 4. 현재 작업 디렉터리
Write-Host "[4/6] 작업 디렉터리 확인..." -ForegroundColor Yellow
$currentDir = (Get-Location).Path
$output += "현재 디렉터리: $currentDir"
Write-Host "  → $currentDir" -ForegroundColor Green

# 5. 디스크 여유 공간 (C 드라이브)
Write-Host "[5/6] 디스크 여유 공간 확인..." -ForegroundColor Yellow
$disk = Get-PSDrive C
$freeSpaceGB = [math]::Round($disk.Free / 1GB, 2)
$totalSpaceGB = [math]::Round(($disk.Used + $disk.Free) / 1GB, 2)
$usedPercent = [math]::Round(($disk.Used / ($disk.Used + $disk.Free)) * 100, 1)
$diskInfo = "$freeSpaceGB GB 남음 / $totalSpaceGB GB (사용률: $usedPercent%)"
$output += "디스크 공간 (C:): $diskInfo"
Write-Host "  → $diskInfo" -ForegroundColor Green

# 6. 인코딩 정보
Write-Host "[6/6] 인코딩 설정 확인..." -ForegroundColor Yellow
$encoding = [Console]::OutputEncoding.EncodingName
$codePage = [Console]::OutputEncoding.CodePage
$encodingInfo = "$encoding (코드페이지: $codePage)"
$output += "출력 인코딩: $encodingInfo"
Write-Host "  → $encodingInfo" -ForegroundColor Green

# 결과를 파일로 저장
Write-Host ""
Write-Host "결과를 system-info-kr-v2.txt에 저장 중..." -ForegroundColor Cyan
$output += ""
$output += "=== 리포트 끝 ==="

# PowerShell 7은 기본적으로 UTF-8 사용
$output | Out-File -FilePath "system-info-kr-v2.txt" -Encoding utf8

Write-Host "✅ 완료! system-info-kr-v2.txt 파일이 생성되었습니다." -ForegroundColor Green
Write-Host ""
Write-Host "📝 참고: PowerShell 7은 기본적으로 UTF-8을 사용하여 한글을 완벽히 지원합니다." -ForegroundColor Gray
