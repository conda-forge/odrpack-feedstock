#!/bin/bash

set -e

echo "Starting Linux/MacOS build script..."

$PYTHON -m pip install . -vv --no-deps --no-build-isolation

if [ $? -ne 0 ]; then
    echo "Build failed. Printing Meson logs..."
    if [ -f "builddir/meson-logs/meson-log.txt" ]; then
        cat "builddir/meson-logs/meson-log.txt"
    else
        echo "Meson log file not found."
    fi
    exit 1
fi