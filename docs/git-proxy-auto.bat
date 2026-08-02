@echo off
setlocal enabledelayedexpansion

rem ===== Config =====
rem Candidate local proxy ports to try (v2rayN/sing-box change over time).
set "PORTS=10808 10813 18080 7890 1080"
set "LANURL=http://10.1.35.75:8099"
set "TESTURL=https://github.com"
set "TIMEOUT=8"

set "MODE=%~1"
if "%MODE%"=="" set "MODE=auto"

echo ==================================================
echo   Git connectivity auto-fix   (mode: %MODE%)
echo ==================================================
echo.

if /I "%MODE%"=="status" goto :report
if /I "%MODE%"=="off"    goto :do_off

rem ---- 1) Try DIRECT first ----
echo Testing DIRECT connection to %TESTURL% ...
call :probe ""
if not "!CODE!"=="000" (
    echo [OK] Direct works ^(http_code=!CODE!^). No proxy needed.
    goto :do_off
)
echo [..] Direct failed. Trying local proxies...
echo.

rem ---- 2) Try each proxy port, socks5h then http ----
for %%P in (%PORTS%) do (
    for %%S in (socks5h http) do (
        call :probe "-x %%S://127.0.0.1:%%P"
        if not "!CODE!"=="000" (
            set "CHOSEN=%%S://127.0.0.1:%%P"
            echo [OK] Proxy !CHOSEN! works ^(http_code=!CODE!^).
            goto :apply
        )
    )
)

echo.
echo [FAIL] Neither direct nor any known proxy could reach %TESTURL%.
echo        Is v2ray/sing-box running? Check its inbound port and add it to PORTS.
echo        Leaving git config unchanged.
goto :report

:apply
git config --global http.proxy  "!CHOSEN!"
git config --global https.proxy "!CHOSEN!"
git config --global "http.%LANURL%.proxy" ""
echo.
echo ==^> Git proxy set to: !CHOSEN!
echo     LAN %LANURL% kept DIRECT.
goto :report

:do_off
git config --global --unset http.proxy  2>nul
git config --global --unset https.proxy 2>nul
git config --global --unset "http.%LANURL%.proxy" 2>nul
echo.
echo ==^> Git set to DIRECT (proxy cleared).
goto :report

:report
echo.
echo ---- current git proxy config ----
echo   http.proxy  =
git config --global --get http.proxy
echo   https.proxy =
git config --global --get https.proxy
echo.
pause
exit /b 0

rem ===== subroutine: probe. arg1 = curl proxy flag ("" for direct). sets CODE (000=fail) =====
:probe
set "CODE=000"
for /f "usebackq delims=" %%C in (`curl -s -o NUL -w "%%{http_code}" --max-time %TIMEOUT% %~1 %TESTURL% 2^>NUL`) do set "CODE=%%C"
if "!CODE!"=="000" exit /b 0
if "!CODE!"=="" set "CODE=000"
exit /b 0
