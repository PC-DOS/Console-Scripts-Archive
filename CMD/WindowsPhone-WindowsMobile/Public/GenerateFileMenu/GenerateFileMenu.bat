@echo off

setlocal EnableExtensions
REM setlocal EnableDelayedExpansionָ��Ϊ���룬��ʹ��ʹ�������������ԱȨ�޵Ĵ���Ҳ����ˡ�
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
REM ɾ��δɾ������ʱ�ļ�
if exist ImageList.tmp (
	del ImageList.tmp
)
REM ö��WIM�ļ�
dir /B /S Images\*.wim > ImageList.tmp
cls
title ӳ���ļ��б�
color 0a
echo ====================
echo ӳ���ļ��б�
echo ����: PC-DOS
echo �汾: N/A
echo ====================
echo=
echo ��ѡ��ӳ���ļ��б�
REM �ļ���ţ�ָ�룩
set /a iIndex = 0
REM ��ʾ�ļ��б�
for /f "tokens=*" %%l in (ImageList.tmp) do (
	REM ָ���1
	set /a iIndex += 1
	REM �г��ļ���ע�⣺�˴�����ʹ��������Ǹ�̾�š�!�����������
	echo [!iIndex!] %%l
)
if !iIndex!==0 (
echo ^<�ļ��б�Ϊ��^>
goto IsImageFolderEmpty
)
:WaitForFileIndex
echo=
echo ��ѡ����Ҫ���ļ��ı�ţ��⿴������"1"��
set /p iSelectedLine=
REM �ݴ�������
REM �Ƚ������һ���� 
REM EQU - ���� 
REM NEQ - ������ 
REM LSS - С�� 
REM LEQ - С�ڻ���� 
REM GTR - ���� 
REM GEQ - ���ڻ���� 
if defined iSelectedLine (
	goto CheckData
) else (
	echo �����������ļ���š�
	goto WaitForFileIndex
)
:CheckData
if %iSelectedLine% GTR !iIndex! (
	echo=
	echo ������ļ���Ź����ѵ���Ϊ���ֵ!iIndex!��
	set iSelectedLine=!iIndex!
)
if %iSelectedLine% LEQ 0 (
	echo=
	echo ������ļ���Ź�С���ѵ���Ϊ��Сֵ1��
	set iSelectedLine=1
)
REM ѡ����·����ע����Ҫ��ѭ���ⶨ��
set "sSelectedFileName ="
REM ��ʱ�ļ���ָ��
set /a iLine = 0
REM ö���в��Ƚ�
for /f "tokens=*" %%l in (ImageList.tmp) do (
	set /a iLine += 1
	if !iLine!==%iSelectedLine% (
		REM �ҵ�ѡ���У�������·������
		set sSelectedFileName=%%l
	)
)
REM ��ӡ·������
echo=
echo ��ѡ����ļ���:
echo %sSelectedFileName%
REM ����DISMָ��
echo=
echo ����DISMָ����:
echo Dism /Apply-Image /ImageFile:"%sSelectedFileName%" /Index:1 /ApplyDir:E:\
pause > nul
REM ɾ����ʱ�ļ�
if exist ImageList.tmp (
	del ImageList.tmp
)
exit

:IsImageFolderEmpty
echo=
echo ����δ���ֿɲ����ӳ���ļ����밴������˳���
REM ɾ����ʱ�ļ�
if exist ImageList.tmp (
	del ImageList.tmp
)
pause > nul
exit

:IsNotAdmin
echo �����޷��Թ���ԱȨ�����У��밴������˳���
pause > nul
exit