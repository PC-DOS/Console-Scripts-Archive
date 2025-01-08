@echo off

cd %~dp0

echo This script will sync child directories in current directory with directories (with same name) in source directory

echo=
echo Please input source directory:
set /p sSource=

REM echo=
REM echo Please input destination directory:
set sDest=%cd%

REM Front sync
echo=
echo Please select front syncing (copying file from "%sSource%" to "%sDest%") operation: A - Copy all, C - Copy newer files (Default after 25 seconds), L - List newer files, S - Skip
choice /C ACLS /N /T 25 /D C
set iSyncOpt=%errorlevel%
echo=
echo Syncing directories...
echo=
for /d %%d in ("%sDest%\*") do (
    if exist "%sSource%\%%~nd" (
        if %iSyncOpt%==1 (
            echo Syncing "%%d" with "%sSource%\%%~nd"...
            xcopy /cheriky "%sSource%\%%~nd\*" "%%d\"
        ) ^
        else if %iSyncOpt%==2 (
            echo Syncing "%%d" with "%sSource%\%%~nd"...
            xcopy /cherikdy "%sSource%\%%~nd\*" "%%d\"
        ) ^
        else if %iSyncOpt%==3 (
            echo Listing differences between "%%d" and "%sSource%\%%~nd"...
            xcopy /cherikdyl "%sSource%\%%~nd\*" "%%d\"
        ) ^
        else (
            echo Skipped syncing of "%%d" and "%sSource%\%%~nd".
        )
        echo=
    )
)

REM Back sync
echo=
echo Please select back syncing (copying file to "%sSource%" to "%sDest%") operation: A - Copy all, C - Copy newer files, L - List newer files (Default after 25 seconds), S - Skip
choice /C ACLS /N /T 25 /D L
set iSyncOpt=%errorlevel%
echo=
echo Syncing directories...
echo=
for /d %%d in ("%sDest%\*") do (
    if exist "%sSource%\%%~nd" (
        if %iSyncOpt%==1 (
            echo Syncing "%sSource%\%%~nd" with "%%d"...
            xcopy /cheriky "%%d\*" "%sSource%\%%~nd\"
        ) ^
        else if %iSyncOpt%==2 (
            echo Syncing "%sSource%\%%~nd" with "%%d"...
            xcopy /cherikdy "%%d\*" "%sSource%\%%~nd\"
        ) ^
        else if %iSyncOpt%==3 (
            echo Listing differences between "%sSource%\%%~nd" and "%%d"...
            xcopy /cherikdyl "%%d\*" "%sSource%\%%~nd\"
        ) ^
        else (
            echo Skipped syncing of "%%d" and "%sSource%\%%~nd".
        )
        echo=
    )
)

echo Operation finished, press any key to exit.
pause > nul