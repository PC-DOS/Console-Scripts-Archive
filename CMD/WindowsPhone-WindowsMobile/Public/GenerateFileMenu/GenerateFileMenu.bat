@echo off

setlocal EnableExtensions
REM setlocal EnableDelayedExpansion指令为必须，即使不使用下述授予管理员权限的代码也是如此。
setlocal EnableDelayedExpansion
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
if ERRORLEVEL 0 (goto IsAdmin) else (goto IsNotAdmin) 

:IsAdmin
REM 删除未删除的临时文件
if exist ImageList.tmp (
	del ImageList.tmp
)
REM 枚举WIM文件
dir /B /S Images\*.wim > ImageList.tmp
cls
title 映像文件列表
color 0a
echo ====================
echo 映像文件列表
echo 編寫: PC-DOS
echo 版本: N/A
echo ====================
echo=
echo 可选的映像文件列表
REM 文件序号（指针）
set /a iIndex = 0
REM 显示文件列表
for /f "tokens=*" %%l in (ImageList.tmp) do (
	REM 指针加1
	set /a iIndex += 1
	REM 列出文件（注意：此处必须使用两个半角感叹号“!”括起变量）
	echo [!iIndex!] %%l
)
if !iIndex!==0 (
echo ^<文件列表为空^>
goto IsImageFolderEmpty
)
:WaitForFileIndex
echo=
echo 请选择需要的文件的编号，这看起来像"1"。
set /p iSelectedLine=
REM 容错（防呆）
REM 比较运算符一览： 
REM EQU - 等于 
REM NEQ - 不等于 
REM LSS - 小于 
REM LEQ - 小于或等于 
REM GTR - 大于 
REM GEQ - 大于或等于 
if defined iSelectedLine (
	goto CheckData
) else (
	echo 错误：请输入文件编号。
	goto WaitForFileIndex
)
:CheckData
if %iSelectedLine% GTR !iIndex! (
	echo=
	echo 输入的文件编号过大，已调整为最大值!iIndex!。
	set iSelectedLine=!iIndex!
)
if %iSelectedLine% LEQ 0 (
	echo=
	echo 输入的文件编号过小，已调整为最小值1。
	set iSelectedLine=1
)
REM 选定的路径，注意需要在循环外定义
set "sSelectedFileName ="
REM 临时文件行指针
set /a iLine = 0
REM 枚举行并比较
for /f "tokens=*" %%l in (ImageList.tmp) do (
	set /a iLine += 1
	if !iLine!==%iSelectedLine% (
		REM 找到选定行，内容送路径变量
		set sSelectedFileName=%%l
	)
)
REM 打印路径变量
echo=
echo 您选择的文件是:
echo %sSelectedFileName%
REM 范例DISM指令
echo=
echo 您的DISM指令是:
echo Dism /Apply-Image /ImageFile:"%sSelectedFileName%" /Index:1 /ApplyDir:E:\
pause > nul
REM 删除临时文件
if exist ImageList.tmp (
	del ImageList.tmp
)
exit

:IsImageFolderEmpty
echo=
echo 错误：未发现可部署的映像文件，请按任意键退出。
REM 删除临时文件
if exist ImageList.tmp (
	del ImageList.tmp
)
pause > nul
exit

:IsNotAdmin
echo 错误：无法以管理员权限运行，请按任意键退出。
pause > nul
exit