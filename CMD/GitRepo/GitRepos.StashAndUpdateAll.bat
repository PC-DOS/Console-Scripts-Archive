@echo off

cd %~dp0
for /d %%f in (*) do (
    if exist "%%f\.git" (
        echo Fetching all updates for "%%f"
        cd "%%f"
        git stash
        git stash clear
        git fetch origin
        git pull origin
        cd ..
        echo=
    )
)

echo Operation finished. Press any key to exit.
pause > nul