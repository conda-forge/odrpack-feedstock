@echo on
setlocal enabledelayedexpansion

echo Starting Windows build script...

:: --- Diagnostic Check Start ---
echo Checking for Fortran runtime libraries...

set "SEARCH_PATH_1=%PREFIX%\Library\lib\flang_rt.runtime.dynamic.lib"
set "SEARCH_PATH_2=%BUILD_PREFIX%\Library\lib\flang_rt.runtime.dynamic.lib"

if exist "%SEARCH_PATH_1%" (
    echo [SUCCESS] Found runtime in HOST prefix: %SEARCH_PATH_1%
) else if exist "%SEARCH_PATH_2%" (
    echo [WARNING] Found runtime in BUILD prefix: %SEARCH_PATH_2%
    :: If it's in build but the linker needs it in host, we might need to point to it
    set "LIB=%BUILD_PREFIX%\Library\lib;%LIB%"
) else (
    echo [ERROR] flang_rt.runtime.dynamic.lib not found in standard locations.
    echo Searching for any flang_rt files in %PREFIX%...
    dir /s /b "%PREFIX%\*flang_rt*"
    
    echo Searching for any flang_rt files in %BUILD_PREFIX%...
    dir /s /b "%BUILD_PREFIX%\*flang_rt*"
)
:: --- Diagnostic Check End ---

clang-cl.exe --version || exit /b 1

set "CC=clang-cl"
set "CXX=clang-cl"

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
if %ERRORLEVEL% neq 0 (
  type %CD%\builddir\meson-logs\meson-log.txt
  exit /b 1
)
