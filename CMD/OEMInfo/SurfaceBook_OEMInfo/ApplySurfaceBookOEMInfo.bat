@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin)

:IsAdmin
echo This tool applies Surface Book OEM Info to your device.
echo=
echo Press any key to start...
pause > nul
echo Copying files...
xcopy /cheriky Info %SystemRoot%\System32\OOBE\Info
echo=
echo Importing registry...
regedit /s OEMInfo_SurfaceBook.reg
reg import OEMInfo_SurfaceBook.reg

echo=
echo Operation finished. Press any key to exit...
pause > nul
exit

:IsNotAdmin
echo ERROR: Please run this program as Administrator. Press any key to exit...
pause > nul
exit