@echo on
setlocal enabledelayedexpansion

echo Starting Windows build script...

:: Add the deep-nested Clang/Flang runtime path to the linker search path
set "LIB=%PREFIX%\Library\lib\clang\21\lib\x86_64-pc-windows-msvc;%LIB%"
set "LIB=%BUILD_PREFIX%\Library\lib\clang\21\lib\x86_64-pc-windows-msvc;%LIB%"

clang-cl.exe --version || exit /b 1

set "CC=clang-cl"
set "CXX=clang-cl"

%PYTHON% -m pip install . -vv --no-deps --no-build-isolation
if %ERRORLEVEL% neq 0 (
  type %CD%\builddir\meson-logs\meson-log.txt
  exit /b 1
)
