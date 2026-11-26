#requires -Version 5.1
# Builds USBSafeProtectWorm-Cleaner.exe with the csc.exe that ships with Windows (.NET Framework 4.x, no SDK needed).
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

$csc = Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319\csc.exe'
if (-not (Test-Path $csc)) { $csc = Join-Path $env:WINDIR 'Microsoft.NET\Framework\v4.0.30319\csc.exe' }
if (-not (Test-Path $csc)) { throw 'csc.exe (.NET Framework 4.x) not found.' }

$out = Join-Path $PSScriptRoot 'bin'
New-Item -ItemType Directory -Force $out | Out-Null

& $csc /nologo /target:winexe /optimize+ `
    /r:System.Management.dll /r:System.Windows.Forms.dll /r:System.Drawing.dll `
    /win32manifest:app.manifest /win32icon:app.ico `
    /out:"$out\USBSafeProtectWorm-Cleaner.exe" USBSafeProtectWorm-Cleaner.cs
if ($LASTEXITCODE -ne 0) { throw "csc failed with exit code $LASTEXITCODE" }

Write-Host "Built $out\USBSafeProtectWorm-Cleaner.exe"
