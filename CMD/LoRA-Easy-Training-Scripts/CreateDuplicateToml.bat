@echo off

cd %~dp0

echo Please input new TOML config prefix
set /p sPrefix=

for /d %%f in (*) do (
    echo Copying "%%f\TrainDetailedTagging.toml" to "%%f\%sPrefix%DetailedTagging.toml"
    if exist "%%f\%sPrefix%DetailedTagging.toml" (
        echo "%%f\%sPrefix%DetailedTagging.toml" already exists
    ) ^
    else (
        copy "%%f\TrainDetailedTagging.toml" "%%f\%sPrefix%DetailedTagging.toml"
    )
    
    echo Copying "%%f\TrainNameOnlyTagging.toml" to "%%f\%sPrefix%NameOnlyTagging.toml"
    if exist "%%f\%sPrefix%NameOnlyTagging.toml" (
        echo "%%f\%sPrefix%DetailedTagging.toml" already exists
    ) ^
    else (
        copy "%%f\TrainNameOnlyTagging.toml" "%%f\%sPrefix%NameOnlyTagging.toml"
    )
    
    md "%%f\OutputDir\%sPrefix%\DetailedTagging"
    md "%%f\OutputDir\%sPrefix%\NameOnlyTagging"
)

echo Operation finished, use a text editor to replace configurations in batch

pause