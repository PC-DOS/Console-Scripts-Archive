@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title 跳過OOBE流程
echo 本應用程式可以為您修改一個非活動Windows映像的登錄檔，以便在無法正常完成OOBE流程時跳過OOBE流程。
echo 請注意: 您仍然需要手動將Administrator使用者設為啟用，否則您可能無法正常登入作業系統。
echo=
echo 請輸入作業系統磁碟區的磁碟機代號，這看上去像"F:":
set /p sSysDev=
reg load HKLM\TARGETSYSTEM %sSysDev%\Windows\System32\Config\SYSTEM
reg import SkipOOBE.reg
regedit /s SkipOOBE.reg
reg unload HKLM\TARGETSYSTEM
echo=
echo 要求的作業已完成，請按任意按鍵以結束。
pause > nul
exit

:IsNotAdmin
echo 錯誤: 無法以系統管理員身分執行此程式，請按任意按鍵以結束。
pause > nul
exit