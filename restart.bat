@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ============================================
echo   Dashboard - Restart Server
echo ============================================
echo.

:: Determine Node.js command
if exist "node\node.exe" (
    set "NODE_CMD=node\node.exe"
) else (
    set "NODE_CMD=node"
)

:: Read configured port
set "DASH_PORT=1111"
if exist "port.conf" (
    set /p DASH_PORT=<port.conf
)

:: Step 1: Stop existing server (PID-based)
if exist ".server.pid" (
    for /f "tokens=*" %%a in ('powershell -Command "try{(Get-Content '.server.pid'|ConvertFrom-Json).pid}catch{}" 2^>nul') do (
        set "OLD_PID=%%a"
    )
    if defined OLD_PID (
        powershell -Command "try{$p=Get-Process -Id !OLD_PID! -ErrorAction Stop;if($p.ProcessName -match 'node'){Stop-Process -Id !OLD_PID! -Force;Write-Host '[OK] Stopped old server (PID: !OLD_PID!)'}}catch{Write-Host '[INFO] Old PID not running'}"
    )
    del ".server.pid" >nul 2>&1
) else (
    echo [INFO] No PID file found
)

:: Step 1b: API-based stop (catches servers without PID file)
powershell -Command "try{Invoke-WebRequest -Uri 'http://127.0.0.1:!DASH_PORT!/api/shutdown' -Method POST -TimeoutSec 2 -ErrorAction Stop|Out-Null;Write-Host '[OK] Sent stop signal to port !DASH_PORT!'}catch{}" 2>nul
timeout /t 2 /nobreak >nul

:: Step 2: Start server
echo [SETUP] Starting server on port !DASH_PORT!...
powershell -WindowStyle Hidden -Command "Start-Process '!NODE_CMD!' -ArgumentList 'server.js' -WorkingDirectory '%~dp0' -WindowStyle Hidden"

:: Step 3: Wait and confirm
timeout /t 3 /nobreak >nul
set "ACTIVE_PORT="
if exist ".server.pid" (
    for /f "tokens=*" %%a in ('powershell -Command "try{(Get-Content '.server.pid'|ConvertFrom-Json).port}catch{}" 2^>nul') do (
        set "ACTIVE_PORT=%%a"
    )
    echo.
    echo [OK] Dashboard server restarted.
    if defined ACTIVE_PORT (
        echo [INFO] Running at http://127.0.0.1:!ACTIVE_PORT!/
    )
) else (
    echo.
    echo [WARN] Server may not have started. Check server.error.log
)
echo.
pause
