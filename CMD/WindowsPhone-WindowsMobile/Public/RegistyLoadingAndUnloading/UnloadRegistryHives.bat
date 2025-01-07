@echo off
title Unload Registry Hives
echo Unloading registry hive 'HKEY_LOCAL_MACHINE\RTSOFTWARE'... 
reg unload HKEY_LOCAL_MACHINE\RTSOFTWARE
echo Unloading registry hive 'HKEY_LOCAL_MACHINE\RTSYSTEM'...
reg unload HKEY_LOCAL_MACHINE\RTSYSTEM
echo=
echo Operation finished. Press any key to exit.
pause > nul