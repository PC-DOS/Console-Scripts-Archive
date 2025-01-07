@echo off
color 0a
title 9008刷机脚本 REV.1 by Leak
echo 本脚本适用于以RX-130 Lumia950系列工程设备。
echo 数据无价，刷机前请注意备份（此操作必须）。
echo 请确保您的设备处于9008状态并已安装相关驱动。

:set
echo 请输入目标设备端口号（范例：COM4请输入4）
set /p com=

:menu
cls
echo 9008刷机脚本 REV.1 by Leak
echo 本脚本适用于以RX-130为代表的一些32GB设备。
echo.
echo 当前选定端口：COM%com%
echo -输入0重新设定端口号码
echo -输入1将备份当前数据
echo -输入2进入刷写
echo -输入3退出程序
echo.
set /p choice=请输入:
if "%choice%"=="0" goto set
if "%choice%"=="1" goto dump
if "%choice%"=="2" goto flash
if "%choice%"=="3" goto exit

:dump
cls
echo 9008刷机脚本 REV.1 by Leak
echo Dump Mode
echo 请输入目标文件名（范例：1.img）。
set /p filename=
emmcdl -p COM%com% -f 8994.mbn -d 0 61071360 -o %filename%
goto menu

:flash
cls
echo 9008刷机脚本 REV.1 by Leak
echo Flash Mode
echo 请将您需要刷入的img文件重命名为Flash.img并放入当前文件夹。
echo 请输入1以确认。
set /p choice=请输入:
if "%choice%"=="1" goto f else goto flash

:f
emmcdl -p COM%com% -f 8994.mbn -x rawprogram0.xml -SetActivePartition 0
goto menu

:exit
pause