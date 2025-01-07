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
bcdedit /store BCD /set "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}" path "\Windows\System32\Boot\developermenu.efi"
bcdedit /store BCD /set "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}" description "Developer Menu"
bcdedit /store BCD /set "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}" device partition="%sMainOS%\EFIESP"
bcdedit /store BCD /set "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}" testsigning on
bcdedit /store BCD /set "{bd8951c4-eabd-4c6f-aafb-4ddb4eb0469b}" nointegritychecks on
echo=
echo Operation finished. Press any key to exit.
pause > nul
exit

:IsNotAdmin
echo Failed to get Admin privilege. Press any key to exit.
pause > nul
exit