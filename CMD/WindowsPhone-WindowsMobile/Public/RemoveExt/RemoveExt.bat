@echo off
cd /d %~dp0
title RemoveExt
echo �������Ƴ�ָ��Ŀ¼�������ļ�����չ����
echo=
echo ��ָ��Ŀ��Ŀ¼��
set /p src=
echo=
echo ִ���С���
attrib -s -r -h /S %src%\*.*
for %%f in (%src%\*) do (echo Executing 'ren "%%f" %%~nf' && ren "%%f" "%%~nf")
echo=
echo ��Ҫ��Ĳ�������ɣ��밴������˳���
pause > nul
exit