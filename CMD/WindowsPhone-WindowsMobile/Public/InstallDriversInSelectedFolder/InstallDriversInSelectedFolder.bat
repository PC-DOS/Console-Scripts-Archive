@echo off
title Driver Installation
echo ������MainOS�������������ţ�������������'E:'��
set /p sMainOS=
echo ���������������ļ��е�·����������������'C:\Drivers'��'Drives'��
set /p sDrivers=
echo=
echo ����ж��ע������õ�Ԫ'HKEY_LOCAL_MACHINE\RTSOFTWARE'... 
reg unload HKEY_LOCAL_MACHINE\RTSOFTWARE
echo ����ж��ע������õ�Ԫ'HKEY_LOCAL_MACHINE\RTSYSTEM'...
reg unload HKEY_LOCAL_MACHINE\RTSYSTEM
echo=
echo ���ڰ�װ�����������...
Dism /Image:%sMainOS% /Add-Driver /Driver:"%sDrivers%" /Recurse /ForceUnsigned
echo=
echo ������ɣ��밴������˳���
pause > nul