@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
title Set Charge Threshold
echo Please mount EFIESP partition into the EFIESP folder in MainOS.
echo=
echo Please input the drive letter of MainOS. It looks like 'E:'.
set /p sMainOS=
echo Please input the Charge Threshold in percentage, the default value is 15.
set iThreshold=15
set /p iThreshold=

echo=
echo Setting charge threshold to %iThreshold%.
cd /d "%sMainOS%\EFIESP\efi\Microsoft\Boot"
bcdedit -store bcd -set {globalsettings} chargethreshold %iThreshold%
echo=
echo Operation finished. Press any key to exit.
pause > nul
exit

:IsNotAdmin
echo Failed to get Admin privilege. Press any key to exit.
pause > nul
exit