@echo off

cd %~dp0

echo This script will sync child directories in current directory with directories (with same name) in source directory

echo=
echo Please input source directory:
set /p sSource=

REM Front sync
echo=
echo Please select front syncing (copying file from "%sSource%") operation: A - Copy all, C - Copy newer files (Default after 25 seconds), L - List newer files, S - Skip
choice /C ACLS /N /T 25 /D C
set iSyncOpt=%errorlevel%
echo=
echo Syncing directories...
echo=
for /d %%d in (*) do (
    if exist "%sSource%\%%d" (
        if %iSyncOpt%==1 (
            echo Syncing "%%d" with "%sSource%\%%d"...
            xcopy /cheriky "%sSource%\%%d\*" "%%d\"
        ) ^
        else if %iSyncOpt%==2 (
            echo Syncing "%%d" with "%sSource%\%%d"...
            xcopy /cherikdy "%sSource%\%%d\*" "%%d\"
        ) ^
        else if %iSyncOpt%==3 (
            echo Listing differences between "%%d" and "%sSource%\%%d"...
            xcopy /cherikdyl "%sSource%\%%d\*" "%%d\"
        ) ^
        else (
            echo Skipped syncing of "%%d" and "%sSource%\%%d".
        )
        echo=
    )
)

REM Back sync
echo=
echo Please select back syncing (copying file to "%sSource%") operation: A - Copy all, C - Copy newer files, L - List newer files (Default after 25 seconds), S - Skip
choice /C ACLS /N /T 25 /D L
set iSyncOpt=%errorlevel%
echo=
echo Syncing directories...
echo=
for /d %%d in (*) do (
    if exist "%sSource%\%%d" (
        if %iSyncOpt%==1 (
            echo Syncing "%sSource%\%%d" with "%%d"...
            xcopy /cheriky "%%d\*" "%sSource%\%%d\"
        ) ^
        else if %iSyncOpt%==2 (
            echo Syncing "%sSource%\%%d" with "%%d"...
            xcopy /cherikdy "%%d\*" "%sSource%\%%d\"
        ) ^
        else if %iSyncOpt%==3 (
            echo Listing differences between "%sSource%\%%d" and "%%d"...
            xcopy /cherikdyl "%%d\*" "%sSource%\%%d\"
        ) ^
        else (
            echo Skipped syncing of "%%d" and "%sSource%\%%d".
        )
        echo=
    )
)

echo Operation finished, press any key to exit.
pause > nul