@echo off

cd %~dp0

echo This script will sync current directory with source directory

echo=
echo Please input source directory:
set /p sSource=

REM Front sync
echo=
echo Please select front syncing (copying file from "%sSource%") operation: A - Copy all, C - Copy newer files (Default after 25 seconds), L - List newer files, S - Skip
choice /C ACLS /N /T 25 /D C
set iSyncOpt=%errorlevel%
echo=
if %iSyncOpt%==1 (
    echo Syncing "%cd%" with "%sSource%\"...
    xcopy /cheriky "%sSource%\*" "%cd%\"
) ^
else if %iSyncOpt%==2 (
    echo Syncing "%cd%" with "%sSource%\"...
    xcopy /cherikdy "%sSource%\*" "%cd%\"
) ^
else if %iSyncOpt%==3 (
    echo Listing differences between "%cd%" and "%sSource%\"...
    xcopy /cherikdyl "%sSource%\*" "%cd%\"
) ^
else (
    echo Skipped syncing of "%cd%" and "%sSource%\".
)
echo=

REM Back sync
echo=
echo Please select back syncing (copying file to "%sSource%") operation: A - Copy all, C - Copy newer files, L - List newer files (Default after 25 seconds), S - Skip
choice /C ACLS /N /T 25 /D L
set iSyncOpt=%errorlevel%
echo=
if %iSyncOpt%==1 (
    echo Syncing "%sSource%\" with "%cd%"...
    xcopy /cheriky "%cd%\*" "%sSource%\"
) ^
else if %iSyncOpt%==2 (
    echo Syncing "%sSource%\" with "%cd%"...
    xcopy /cherikdy "%sSource%\*" "%cd%\"
) ^
else if %iSyncOpt%==3 (
    echo Listing differences between "%sSource%\" and "%cd%"...
    xcopy /cherikdyl "%cd%\*" "%sSource%\"
) ^
else (
    echo Skipped syncing of "%sSource%\" and "%cd%".
)

echo Operation finished, press any key to exit.
pause > nul