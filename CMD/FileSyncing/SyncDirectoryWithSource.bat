@echo off

cd %~dp0

echo This script will sync destination directory with source directory

echo=
echo Please input source directory:
set /p sSource=

echo=
echo Please input destination directory:
set /p sDest=

REM Front sync
echo=
echo Please select front syncing (copying file from "%sSource%" to "%sDest%") operation: A - Copy all, C - Copy newer files (Default after 25 seconds), L - List newer files, S - Skip
choice /C ACLS /N /T 25 /D C
set iSyncOpt=%errorlevel%
echo=
if %iSyncOpt%==1 (
    echo Syncing "%sDest%" with "%sSource%\"...
    xcopy /cheriky "%sSource%\*" "%sDest%\"
) ^
else if %iSyncOpt%==2 (
    echo Syncing "%sDest%" with "%sSource%\"...
    xcopy /cherikdy "%sSource%\*" "%sDest%\"
) ^
else if %iSyncOpt%==3 (
    echo Listing differences between "%sDest%" and "%sSource%\"...
    xcopy /cherikdyl "%sSource%\*" "%sDest%\"
) ^
else (
    echo Skipped syncing of "%sDest%" and "%sSource%\".
)

REM Back sync
echo=
echo Please select back syncing (copying file from "%sDest%" to "%sSource%") operation: A - Copy all, C - Copy newer files, L - List newer files (Default after 25 seconds), S - Skip
choice /C ACLS /N /T 25 /D L
set iSyncOpt=%errorlevel%
echo=
if %iSyncOpt%==1 (
    echo Syncing "%sSource%\" with "%sDest%"...
    xcopy /cheriky "%sDest%\*" "%sSource%\"
) ^
else if %iSyncOpt%==2 (
    echo Syncing "%sSource%\" with "%sDest%"...
    xcopy /cherikdy "%sDest%\*" "%sSource%\"
) ^
else if %iSyncOpt%==3 (
    echo Listing differences between "%sSource%\" and "%sDest%"...
    xcopy /cherikdyl "%sDest%\*" "%sSource%\"
) ^
else (
    echo Skipped syncing of "%sSource%\" and "%sDest%".
)

echo=
echo Operation finished, press any key to exit.
pause > nul