@echo off

setlocal EnableExtensions
REM setlocal EnableDelayedExpansionָ��Ϊ���룬��ʹ��ʹ���������ԱȨ�޵Ĵ���Ҳ����ˡ�

echo FFU File Name Auto Fill Demo
echo=
echo ������·�����⿴������'D:\Flashing\'
set /p sPath=

for %%f in ("%sPath%\*.ffu") do (
	set sFFUFile=%%~ff
)

REM �ж��Ƿ���FFU�ļ�
if "%sFFUFile%"=="" (
	echo=
	echo û���ҵ�FFU�ļ���
	pause > nul
	exit
)

echo=
echo �Զ�ʶ���FFU�ļ�Ϊ��
echo "%sFFUFile%"

pause > nul
exit
