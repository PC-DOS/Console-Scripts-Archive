@echo off

setlocal EnableExtensions
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
cls
title MSM8994̎�������Ĕ����i����ʽ
color 0a
echo ====================
echo MSM8994̎�������Ĕ����i����ʽ
echo ���� PC-DOS
echo �汾��MSM8994CoreLocker.AnyCPU.FRE.20190322-1325
echo ====================
echo=
echo ����ʽ�鹩�i��MSM8994̎�������Ĕ���֮�á��_ʼǰ��Ո�_���b�õ�EFIESP�օ^���Ա���ȡ��Ո�ձ���ϵ�y����T��ֈ��д˳�ʽ��
echo=
echo Ո�����ⰴ�I���_ʼ��
pause > nul
cls
echo �����L��������YӍ...
echo=
echo Ոݔ��EFIESP�ŵ��^�Ĵŵ��C��̖��λ�ã��@����ȥ��"E:"����"F:\EFIESP":
set /p sEFIESP=
cls

:Start
echo BCD�ļ�λ��: %sEFIESP%\EFI\Microsoft\Boot\BCD
echo ���ڌ�߉݋̎���������{����4...
bcdedit /store "%sEFIESP%\EFI\Microsoft\Boot\BCD" /set {default} numproc 4
echo=
echo ��Ҫ������I����ɣ�Ո�����ⰴ�I�ԽY����
pause > nul
exit

:IsNotAdmin
echo �e�`: �o����ϵ�y����T��ֈ��д˳�ʽ��Ո�����ⰴ�I�ԽY����
pause > nul
exit