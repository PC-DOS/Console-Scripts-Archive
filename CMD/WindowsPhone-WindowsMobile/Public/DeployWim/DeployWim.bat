@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title WIM部署工具
color 0a
echo ====================
echo WIM部署工具
echo 编写： PC-DOS
echo 版本：N/A
echo ====================
echo=
echo 本工具释放WIM文件到指定的硬盘分区。
echo=
REM if not exist install.wim goto NeedWim
echo 请输入释放目标的驱动器号，这看起来像'E:'。
set /p sTarget=
echo=
echo 请输入需要释放的WIM文件的路径，这看起来像'D:\Images\install.wim'或者'\Images\install.wim'。
set /p sInstall=
REM set sInstall=install.wim
echo=
echo 需要释放的分卷映像编号，这看起来像'1':
set /p iIndex=
REM set iIndex=1
echo=
echo 正在释放映像……
Dism /Apply-Image /ImageFile:"%sInstall%" /Index:%iIndex% /ApplyDir:%sTarget%
echo=
echo 操作已完成，请按任意键退出。
pause > nul
exit

:IsNotAdmin
echo 错误：无法以管理员身份运行，请按任意键退出。
pause > nul
exit

:NeedWim
echo 作为映像的文件'install.wim'不存在，请确保该文件已被置于程序所在的目录下。
echo=
echo 请按任意键退出。
pause > nul
exit