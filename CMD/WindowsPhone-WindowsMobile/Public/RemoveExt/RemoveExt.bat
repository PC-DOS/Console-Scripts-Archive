@echo off
cd /d %~dp0
title RemoveExt
echo 本工具移除指定目录下所有文件的扩展名。
echo=
echo 请指定目标目录：
set /p src=
echo=
echo 执行中……
attrib -s -r -h /S %src%\*.*
for %%f in (%src%\*) do (echo Executing 'ren "%%f" %%~nf' && ren "%%f" "%%~nf")
echo=
echo 所要求的操作已完成，请按任意键退出。
pause > nul
exit