@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title MSM8994處理器核心數量鎖定程式
color 0a
echo ====================
echo MSM8994處理器核心數量鎖定程式
echo 編寫 PC-DOS
echo 版本：MSM8994CoreLocker.AnyCPU.FRE.20190322-1325
echo ====================
echo=
echo 本程式為供鎖定MSM8994處理器核心數量之用。開始前，請確保裝置的EFIESP分區可以被存取。請務必以系統管理員身分執行此程式。
echo=
echo 請按任意按鍵以開始。
pause > nul
cls
echo 正在蒐集所需的資訊...
echo=
echo 請輸入EFIESP磁碟區的磁碟機代號或位置，這看上去像"E:"或者"F:\EFIESP":
set /p sEFIESP=
cls

:Start
echo BCD文件位置: %sEFIESP%\EFI\Microsoft\Boot\BCD
echo 正在將邏輯處理器數量調整為4...
bcdedit /store "%sEFIESP%\EFI\Microsoft\Boot\BCD" /set {default} numproc 4
echo=
echo 所要求的作業已完成，請按任意按鍵以結束。
pause > nul
exit

:IsNotAdmin
echo 錯誤: 無法以系統管理員身分執行此程式，請按任意按鍵以結束。
pause > nul
exit