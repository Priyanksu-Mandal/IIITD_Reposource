#!/bin/csh -f

# Cadence Virtuoso launcher
# Used directly or as a template for install.sh.

set WORKSPACE = "$HOME/Desktop/cmos65"
set ENV_FILE = ".cshrc_cmos065"

if (! -d "$WORKSPACE") then
    echo "ERROR: Cadence workspace does not exist:"
    echo "  $WORKSPACE"
    exit 1
endif

cd "$WORKSPACE"

if (! -f "$ENV_FILE") then
    echo "ERROR: Environment file does not exist:"
    echo "  $WORKSPACE/$ENV_FILE"
    exit 1
endif

source "./$ENV_FILE"

echo "Starting Cadence Virtuoso..."
virtuoso &
