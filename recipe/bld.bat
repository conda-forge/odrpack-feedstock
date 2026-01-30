@echo on
setlocal enabledelayedexpansion

echo Starting Windows build script...

clang-cl.exe --version || exit /b 1

set "CC=clang-cl"
set "CXX=clang-cl"

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
if %ERRORLEVEL% neq 0 (
  type %CD%\builddir\meson-logs\meson-log.txt
  exit /b 1
)
