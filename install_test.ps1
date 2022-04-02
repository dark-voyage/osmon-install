#!/usr/bin/env pwsh

$ErrorActionPreference = 'Stop'

# Test that we can install the latest version at the default location.
Remove-Item "~\.osmon" -Recurse -Force -ErrorAction SilentlyContinue
$env:OSMON_INSTALL = ""
$v = $null; .\install.ps1
~\.osmon\bin\osmon.exe --version

# Test that we can install a specific version at a custom location.
Remove-Item "~\osmon-0.2.0" -Recurse -Force -ErrorAction SilentlyContinue
$env:OSMON_INSTALL = "$Home\osmon-0.2.0"
$v = "1.0.0"; .\install.ps1
$OsmonVersion = ~\osmon-0.2.0\bin\osmon.exe --version
if (!($OsmonVersion -like '*1.0.0*')) {
  throw $OsmonVersion
}

# Test that we can install at a relative custom location.
Remove-Item "bin" -Recurse -Force -ErrorAction SilentlyContinue
$env:OSMON_INSTALL = "."
$v = "1.1.0"; .\install.ps1
$OsmonVersion = bin\osmon.exe --version
if (!($OsmonVersion -like '*1.1.0*')) {
  throw $OsmonVersion
}

# Test that the old temp file installer still works.
Remove-Item "~\osmon-0.2.0" -Recurse -Force -ErrorAction SilentlyContinue
$env:OSMON_INSTALL = "$Home\osmon-0.2.0"
$v = $null; .\install.ps1 v1.0.1
$OsmonVersion = ~\osmon-0.2.0\bin\osmon.exe --version
if (!($OsmonVersion -like '*1.0.1*')) {
  throw $OsmonVersion
}
