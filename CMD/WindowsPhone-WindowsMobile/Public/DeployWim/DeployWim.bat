@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title WIM���𹤾�
color 0a
echo ====================
echo WIM���𹤾�
echo ��д�� PC-DOS
echo �汾��N/A
echo ====================
echo=
echo �������ͷ�WIM�ļ���ָ����Ӳ�̷�����
echo=
REM if not exist install.wim goto NeedWim
echo �������ͷ�Ŀ����������ţ��⿴������'E:'��
set /p sTarget=
echo=
echo ��������Ҫ�ͷŵ�WIM�ļ���·�����⿴������'D:\Images\install.wim'����'\Images\install.wim'��
set /p sInstall=
REM set sInstall=install.wim
echo=
echo ��Ҫ�ͷŵķ־�ӳ���ţ��⿴������'1':
set /p iIndex=
REM set iIndex=1
echo=
echo �����ͷ�ӳ�񡭡�
Dism /Apply-Image /ImageFile:"%sInstall%" /Index:%iIndex% /ApplyDir:%sTarget%
echo=
echo ��������ɣ��밴������˳���
pause > nul
exit

:IsNotAdmin
echo �����޷��Թ���Ա������У��밴������˳���
pause > nul
exit

:NeedWim
echo ��Ϊӳ����ļ�'install.wim'�����ڣ���ȷ�����ļ��ѱ����ڳ������ڵ�Ŀ¼�¡�
echo=
echo �밴������˳���
pause > nul
exit