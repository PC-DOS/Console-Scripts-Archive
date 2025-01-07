@echo off
title Load Registry Hives
echo Please input the drive letter of MainOS. It looks like 'E:'.
set /p sMainOS=
echo=
echo Loading hives...
reg load HKEY_LOCAL_MACHINE\RTSOFTWARE "%sMainOS%\Windows\System32\config\SOFTWARE"
reg load HKEY_LOCAL_MACHINE\RTSYSTEM "%sMainOS%\Windows\System32\config\SYSTEM"
echo=
echo Operation finished. 
echo '%sMainOS%\Windows\System32\config\SYSTEM' should have been loaded as 'HKEY_LOCAL_MACHINE\RTSYSTEM'.
echo '%sMainOS%\Windows\System32\config\SOFTWARE' should have been loaded as 'HKEY_LOCAL_MACHINE\RTSOFTWARE'.
echo=
echo Press any key to exit.
pause > nul