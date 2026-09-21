@echo off
setlocal enabledelayedexpansion

rem ===== Config =====
rem Candidate local proxy ports (v2rayN socks=10808 / http=10809; sing-box varies).
set "PORTS=10808 10809 10810 10811 7890 1080 2080"
rem Schemes tried per port, in priority order.
set "SCHEMES=socks5h http"
rem LAN git server kept DIRECT (never proxied). Leave blank to skip.
set "LANURL=http://10.1.35.75:8099"
set "TESTURL=https://github.com"
rem Real git endpoint used for final verification (public repo).
set "GITURL=https://github.com/git/git"
set "CONNECT=4"
set "TIMEOUT=8"
set "RETRIES=3"
set "GIT_TERMINAL_PROMPT=0"

set "MODE=%~1"
if "%MODE%"=="" set "MODE=auto"

echo ==================================================
echo   Git connectivity auto-fix   (mode: %MODE%)
echo ==================================================
echo.

if /I "%MODE%"=="status" goto :report
if /I "%MODE%"=="off"    goto :do_off

rem ---- 1) Try DIRECT first (bypass any system proxy; retry to ride out v2ray startup) ----
echo Testing DIRECT connection to %TESTURL% ...
call :probe "--noproxy *"
if not "!CODE!"=="000" (
    echo [OK] Direct reachable ^(http_code=!CODE!^). Verifying with real git...
    call :gitcheck ""
    if "!GITOK!"=="1" (
        echo [OK] git works DIRECT. No proxy needed.
        goto :do_off
    )
    echo [..] curl direct ok but git failed. Trying proxies...
) else (
    echo [..] Direct failed after %RETRIES% tries. Trying local proxies...
)
echo.

rem ---- 2) Try each proxy port/scheme; a candidate must pass a REAL git ls-remote ----
for %%P in (%PORTS%) do (
    for %%S in (%SCHEMES%) do (
        call :probe "-x %%S://127.0.0.1:%%P"
        if not "!CODE!"=="000" (
            echo [..] curl via %%S://127.0.0.1:%%P ok ^(http_code=!CODE!^). Verifying git...
            call :gitcheck "%%S://127.0.0.1:%%P"
            if "!GITOK!"=="1" (
                set "CHOSEN=%%S://127.0.0.1:%%P"
                echo [OK] git works via !CHOSEN!.
                goto :apply
            )
        )
    )
)

echo.
echo [FAIL] No working path (direct/proxy/LAN) could reach %TESTURL% right now.
echo        Clearing git proxy so it self-heals once a path comes back.
echo        (Start v2ray/sing-box or select a node, then re-run this script.)
goto :do_off

rem ================= subroutines =================

:apply
git config --global http.proxy  "!CHOSEN!"
git config --global https.proxy "!CHOSEN!"
if not "%LANURL%"=="" (
    rem Keep the LAN git server direct even while global proxy is set.
    git config --global http."%LANURL%".proxy ""
)
echo.
echo [DONE] git proxy set to !CHOSEN!
goto :report

:do_off
git config --global --unset http.proxy  >nul 2>&1
git config --global --unset https.proxy >nul 2>&1
if not "%LANURL%"=="" git config --global --unset http."%LANURL%".proxy >nul 2>&1
echo.
echo [DONE] git proxy cleared (DIRECT).
goto :report

rem probe %1 = curl proxy args ("--noproxy *" or "-x scheme://host:port"). Sets CODE (last non-000 wins).
:probe
set "CODE=000"
for /l %%i in (1,1,%RETRIES%) do (
    if "!CODE!"=="000" (
        for /f %%c in ('curl -s -o NUL -w "%%{http_code}" %~1 --connect-timeout %CONNECT% --max-time %TIMEOUT% "%TESTURL%" 2^>NUL') do set "CODE=%%c"
    )
)
exit /b 0

rem gitcheck %1 = proxy url ("" for direct). Sets GITOK=1 on success.
:gitcheck
set "GITOK=0"
if "%~1"=="" (
    git -c http.proxy= -c https.proxy= ls-remote "%GITURL%" HEAD >nul 2>&1
) else (
    git -c http.proxy=%~1 -c https.proxy=%~1 ls-remote "%GITURL%" HEAD >nul 2>&1
)
if not errorlevel 1 set "GITOK=1"
exit /b 0

:report
echo.
echo ---- current git proxy config ----
for /f "tokens=*" %%v in ('git config --global --get http.proxy')  do echo   http.proxy  = %%v
for /f "tokens=*" %%v in ('git config --global --get https.proxy') do echo   https.proxy = %%v
echo.
pause
endlocal
