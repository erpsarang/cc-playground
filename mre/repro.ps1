# mre\repro.ps1
$filePath = ".\THIS_FILE_DOES_NOT_EXIST.txt"
if (Test-Path $filePath) {
    Get-Content $filePath
} else {
    Write-Error "File not found: $filePath"
}

