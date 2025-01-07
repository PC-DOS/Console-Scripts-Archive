@echo off

setlocal EnableExtensions
REM setlocal EnableDelayedExpansion指令为必须，即使不使用授予管理员权限的代码也是如此。

echo FFU File Name Auto Fill Demo
echo=
echo 请输入路径，这看起来像'D:\Flashing\'
set /p sPath=

for %%f in ("%sPath%\*.ffu") do (
	set sFFUFile=%%~ff
)

REM 判断是否有FFU文件
if "%sFFUFile%"=="" (
	echo=
	echo 没有找到FFU文件！
	pause > nul
	exit
)

echo=
echo 自动识别的FFU文件为：
echo "%sFFUFile%"

pause > nul
exit
