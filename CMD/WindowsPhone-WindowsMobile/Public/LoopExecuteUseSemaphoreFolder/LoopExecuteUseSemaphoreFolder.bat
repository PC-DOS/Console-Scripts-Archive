@echo off

:Start
cd %~dp0

REM Insert main code here.
echo Sample

REM Wait for about 5 seconds.
ping 127.0.0.1 -n 5 > nul

REM Set semaphore folder path here.
if exist ".\Semaphore" (
	goto End
)
echo=
echo Script finished, but semaphore folder not detected, retrying...
goto Start

:End
echo=
echo Semaphore folder detected, press any key to exit.
pause > nul
Exit