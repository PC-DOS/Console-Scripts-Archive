@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title ���^OOBE����
echo �����ó�ʽ���Ԟ����޸�һ���ǻ��Windowsӳ��ĵ�䛙n���Ա��ڟo���������OOBE���̕r���^OOBE���̡�
echo Ոע��: ����Ȼ��Ҫ�քӌ�Administratorʹ�����O�醢�ã���t�����ܟo�������������Iϵ�y��
echo=
echo Ոݔ�����Iϵ�y�ŵ��^�Ĵŵ��C��̖���@����ȥ��"F:":
set /p sSysDev=
reg load HKLM\TARGETSYSTEM %sSysDev%\Windows\System32\Config\SYSTEM
reg import SkipOOBE.reg
regedit /s SkipOOBE.reg
reg unload HKLM\TARGETSYSTEM
echo=
echo Ҫ������I����ɣ�Ո�����ⰴ�I�ԽY����
pause > nul
exit

:IsNotAdmin
echo �e�`: �o����ϵ�y����T��ֈ��д˳�ʽ��Ո�����ⰴ�I�ԽY����
pause > nul
exit