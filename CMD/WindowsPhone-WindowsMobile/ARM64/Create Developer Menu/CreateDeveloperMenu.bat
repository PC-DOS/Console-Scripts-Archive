@echo off
cd /d %~dp0
title 添加適用於AArch64的開發人員選單
echo 本應用程式為安裝了適用於AArch64的Windows 10的RX-130與RX-127裝置安裝開發人員選單。
echo 作者：五塊二
echo=
echo 請輸入EFIESP磁碟區的磁碟機代號，這看上去像"E:":
set /p P=
echo 正在複製文件...
md %P%\Windows
xcopy /cheriky "%cd%\Windows\*" %drive%\Windows
echo 正在寫入登錄檔...
bcdedit /store %P%\efi\microsoft\boot\BCD > nul
reg load HKLM\TARGETBCD %P%\efi\microsoft\boot\BCD
reg import Microsoft.BCD.KeyActions.Test_BCDStore_0.reg
reg unload HKLM\TARGETBCD
goto check

:check
bcdedit /store %P%\efi\microsoft\boot\BCD >nul
if errorlevel 1 (goto error
) else (
        echo 所要求的作業已成功完成，您可以在開機時按住 [電源] 鍵以進入開發人員選單。
        echo 請按任意按鍵以結束。
        pause > nul
        exit
)
:error
echo 作業中存在錯誤，請按任意按鍵以結束。
pause > nul
exit        


