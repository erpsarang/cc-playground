# Windows PowerShell UTF-8 Encoding Setup Guide

## Current Issue
Windows PowerShell 5.x uses code page 949 (EUC-KR) by default, which causes issues with Korean text in scripts.

## Solutions

### Solution 1: Use PowerShell 7 (Recommended)
PowerShell 7 (pwsh) uses UTF-8 by default.

**Check if PowerShell 7 is installed:**
```powershell
pwsh --version
```

**Install PowerShell 7 (if not installed):**
```powershell
winget install Microsoft.PowerShell
```

**Run scripts with PowerShell 7:**
```powershell
pwsh -File script.ps1
```

### Solution 2: Configure Git for UTF-8 (Already Done)
```bash
git config --global core.quotepath false
git config --global gui.encoding utf-8
git config --global i18n.commitencoding utf-8
git config --global i18n.logoutputencoding utf-8
```

### Solution 3: Set UTF-8 in Each Script
Add this at the beginning of PowerShell scripts:
```powershell
# Set UTF-8 encoding
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
```

### Solution 4: Save Files with UTF-8 BOM
PowerShell 5.x requires UTF-8 with BOM for Korean text:
```powershell
$content = "your content"
$utf8Bom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText("file.ps1", $content, $utf8Bom)
```

### Solution 5: Use Windows Terminal
Windows Terminal has better UTF-8 support than legacy console.

## Current Configuration Status
- ✅ Git UTF-8 configured globally
- ✅ Git user configured (erpsarang, sangyeul.han@gmail.com)
- ⚠️ PowerShell 5.x still uses code page 949
- 💡 Consider upgrading to PowerShell 7 for better Unicode support

## Testing
Run this command to check current encoding:
```powershell
[Console]::OutputEncoding.EncodingName
chcp
```

Expected output with UTF-8:
```
Unicode (UTF-8)
Active code page: 65001
```
