@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
title Add Developer Menu (ARM32)
echo Please mount EFIESP partition into the EFIESP folder in MainOS.
echo=
echo Please input the drive letter of MainOS. It looks like 'E:'.
set /p sMainOS=

echo=
echo Applying Developer Menu (ARM32)...
xcopy /cheriky .\developermenu\* "%sMainOS%\EFIESP\Windows\System32\Boot\"
cd /d "%sMainOS%\EFIESP\efi\Microsoft\Boot"
bcdedit /store BCD /create "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" /application bootapp /d "Developer Menu"
bcdedit /store BCD /set "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" path "\Windows\System32\Boot\developermenu.efi"
bcdedit /store BCD /set "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" inherit "{bootloadersettings}"
bcdedit /store BCD /set "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" device partition="%sMainOS%\EFIESP"
bcdedit /store BCD /set "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" testsigning on
bcdedit /store BCD /set "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" nointegritychecks on
bcdedit /store BCD /set "{bootmgr}" displaybootmenu on
bcdedit /store BCD /set "{bootmgr}" timeout 25
bcdedit /store BCD /deletevalue "{bootmgr}" customactions
bcdedit /store BCD /deletevalue "{bootmgr}" custom:54000001
bcdedit /store BCD /deletevalue "{bootmgr}" custom:54000002
bcdedit /store BCD /displayorder "{default}" "{DCC0BD7C-ED9D-49D6-AF62-23A3D901117B}" "{0ff5f24a-3785-4aeb-b8fe-4226215b88c4}" "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}"
echo=
echo Operation finished. Press any key to exit.
pause > nul
exit

:IsNotAdmin
echo Failed to get Admin privilege. Press any key to exit.
pause > nul
exit