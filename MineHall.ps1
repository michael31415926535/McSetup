if ($ExecutionContext.SessionState.LanguageMode -ne "FullLanguage") {
   Write-Host "[!] Error: The auto-installer is unable to run on your system. PowerShell execution is restricted by security policies" -ForegroundColor Red
   Write-Output ""
   Write-Output "Press enter to exit..."
   Read-Host | Out-Null
   Exit
}

try {
    Write-Host "[*] Downloading the latest MineHall Setup installer..." -ForegroundColor Yellow
    $LatestVersion = 'https://github.com/michael31415926535/McSetup/raw/refs/heads/main/MineHallSetup.exe'
    Invoke-RestMethod $LatestVersion -OutFile "$env:TEMP\MineHallSetup.exe"
}
catch {
    Write-Host "[!] Error: Unable to download the installer." -ForegroundColor Red
    Write-Host "    Error Message: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "    Exception Details: $($_.Exception)" -ForegroundColor Red
    Write-Output ""
    Write-Output "    Press enter to exit..."
    Read-Host | Out-Null
    Exit
}
Write-Host "[+] Running MineHall Setup..." -ForegroundColor Green

Start-Process "$env:TEMP\MineHallSetup.exe"