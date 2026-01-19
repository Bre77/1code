#!/bin/bash
# Local build script with workarounds for macOS development environment
# Use this instead of `bun run package:mac` when building locally

set -e

# Workaround: Python 3.12+ removed distutils, use Python 3.11 for node-gyp
if command -v python3.11 &> /dev/null; then
    export PYTHON=$(which python3.11)
    echo "Using Python: $PYTHON"
else
    echo "Warning: python3.11 not found, node-gyp may fail with Python 3.12+"
    echo "Install with: brew install python@3.11"
fi

# Run the build
echo "Building for macOS..."
bun install
bun run claude:download
bun run build
bun run package:mac
