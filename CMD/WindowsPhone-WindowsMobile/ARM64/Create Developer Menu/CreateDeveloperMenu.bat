@echo off
cd /d %~dp0
title ����m���AArch64���_�l�ˆT�x��
echo �����ó�ʽ�鰲�b���m���AArch64��Windows 10��RX-130�cRX-127�b�ð��b�_�l�ˆT�x�Ρ�
echo ���ߣ���K��
echo=
echo Ոݔ��EFIESP�ŵ��^�Ĵŵ��C��̖���@����ȥ��"E:":
set /p P=
echo �����}�u�ļ�...
md %P%\Windows
xcopy /cheriky "%cd%\Windows\*" %drive%\Windows
echo ���ڌ����䛙n...
bcdedit /store %P%\efi\microsoft\boot\BCD > nul
reg load HKLM\TARGETBCD %P%\efi\microsoft\boot\BCD
reg import Microsoft.BCD.KeyActions.Test_BCDStore_0.reg
reg unload HKLM\TARGETBCD
goto check

:check
bcdedit /store %P%\efi\microsoft\boot\BCD >nul
if errorlevel 1 (goto error
) else (
        echo ��Ҫ������I�ѳɹ���ɣ����������_�C�r��ס [�Դ] �I���M���_�l�ˆT�x�Ρ�
        echo Ո�����ⰴ�I�ԽY����
        pause > nul
        exit
)
:error
echo ���I�д����e�`��Ո�����ⰴ�I�ԽY����
pause > nul
exit        


