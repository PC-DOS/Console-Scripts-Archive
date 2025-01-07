@echo off
title Driver Installation
echo 请输入MainOS分区的驱动器号，它看起来就像'E:'。
set /p sMainOS=
echo 请输入驱动程序文件夹的路径，它看起来就像'C:\Drivers'或'Drives'。
set /p sDrivers=
echo=
echo 正在卸载注册表配置单元'HKEY_LOCAL_MACHINE\RTSOFTWARE'... 
reg unload HKEY_LOCAL_MACHINE\RTSOFTWARE
echo 正在卸载注册表配置单元'HKEY_LOCAL_MACHINE\RTSYSTEM'...
reg unload HKEY_LOCAL_MACHINE\RTSYSTEM
echo=
echo 正在安装驱动程序软件...
Dism /Image:%sMainOS% /Add-Driver /Driver:"%sDrivers%" /Recurse /ForceUnsigned
echo=
echo 操作完成，请按任意键退出。
pause > nul