@echo off
cd /d %~dp0
title PackAll
echo This tool packs all the files in a specified directory using gzip format.
echo=
echo Please input source directory:
set /p src=
echo=
echo Please input output directory:
set /p opt=
echo=
echo Please input extension name (use * to set it to an empty string):
set /p ext=
echo=
echo Processing...
if "%ext%"=="*" (
	for /f %%f in ('dir /b "%src%"') do (7z a -tgzip "%opt%\%%f" "%src%\%%f")
) else (
	for /f %%f in ('dir /b "%src%"') do (7z a -tgzip "%opt%\%%f.%ext%" "%src%\%%f")
)
echo=
echo Operation finished. Press any key to exit.
pause > nul