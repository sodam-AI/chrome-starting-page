@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

if "%~1"=="" (
    if exist "port.conf" (
        set /p CURRENT=<port.conf
        echo Current port: !CURRENT!
    ) else (
        echo Current port: 1111 (default)
    )
    echo.
    set /p NEW_PORT="New port: "
) else (
    set "NEW_PORT=%~1"
)

echo %NEW_PORT%> port.conf
echo [OK] Port set to %NEW_PORT%
echo.
echo Restart the server for changes to take effect.
echo   - Run restart.bat, or
echo   - Set Chrome start page to http://localhost:%NEW_PORT%
pause
