#!/bin/bash

set -e

APP_NAME="virtuoso-cmos65"
APP_DIR="$HOME/.local/share/applications"
INSTALL_DIR="$HOME/.local/share/cadence-virtuoso-launcher"

echo "=============================================="
echo " Cadence Virtuoso Linux Launcher Installer"
echo "=============================================="
echo

CSH_PATH=""

if command -v csh >/dev/null 2>&1; then
    CSH_PATH="$(command -v csh)"
elif command -v tcsh >/dev/null 2>&1; then
    CSH_PATH="$(command -v tcsh)"
fi

if [ -z "$CSH_PATH" ]; then
    echo "ERROR: csh/tcsh was not found."
    echo "Install C Shell and run this installer again."
    exit 1
fi

echo "C Shell found: $CSH_PATH"
echo

DEFAULT_WORKSPACE="$HOME/Desktop/cmos65"
read -r -p "Cadence workspace directory [$DEFAULT_WORKSPACE]: " WORKSPACE
WORKSPACE="${WORKSPACE:-$DEFAULT_WORKSPACE}"

if [[ "$WORKSPACE" == "~/"* ]]; then
    WORKSPACE="$HOME/${WORKSPACE#~/}"
fi

WORKSPACE="${WORKSPACE%/}"

if [ ! -d "$WORKSPACE" ]; then
    echo
    echo "WARNING: Workspace does not currently exist:"
    echo "  $WORKSPACE"
    read -r -p "Continue anyway? [y/N]: " CONTINUE
    if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

DEFAULT_ENV=".cshrc_cmos065"
read -r -p "Environment file [$DEFAULT_ENV]: " ENV_FILE
ENV_FILE="${ENV_FILE:-$DEFAULT_ENV}"

read -r -p "Create a desktop shortcut? [Y/n]: " DESKTOP_CHOICE
DESKTOP_CHOICE="${DESKTOP_CHOICE:-Y}"

mkdir -p "$INSTALL_DIR"
mkdir -p "$APP_DIR"

cat > "$INSTALL_DIR/launch_virtuoso.csh" <<EOF
#!/bin/csh -f

set WORKSPACE = "$WORKSPACE"
set ENV_FILE = "$ENV_FILE"

if (! -d "\$WORKSPACE") then
    echo "ERROR: Cadence workspace does not exist:"
    echo "  \$WORKSPACE"
    exit 1
endif

cd "\$WORKSPACE"

if (! -f "\$ENV_FILE") then
    echo "ERROR: Environment file does not exist:"
    echo "  \$WORKSPACE/\$ENV_FILE"
    exit 1
endif

source "./\$ENV_FILE"

echo "Starting Cadence Virtuoso..."
virtuoso &
EOF

chmod +x "$INSTALL_DIR/launch_virtuoso.csh"

DESKTOP_FILE="$APP_DIR/$APP_NAME.desktop"

cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Cadence Virtuoso (CMOS 65nm)
Comment=Launch Cadence Virtuoso with the configured PDK environment
Exec=$CSH_PATH -c "$INSTALL_DIR/launch_virtuoso.csh"
Icon=utilities-terminal
Terminal=false
Categories=Development;Engineering;Electronics;
StartupNotify=true
EOF

chmod +x "$DESKTOP_FILE"

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
fi

if [[ "$DESKTOP_CHOICE" =~ ^[Yy]$ ]]; then
    DESKTOP_DIR="$HOME/Desktop"

    if [ -d "$DESKTOP_DIR" ]; then
        cp "$DESKTOP_FILE" "$DESKTOP_DIR/$APP_NAME.desktop"
        chmod +x "$DESKTOP_DIR/$APP_NAME.desktop"
        echo
        echo "Desktop shortcut created:"
        echo "  $DESKTOP_DIR/$APP_NAME.desktop"
    fi
fi

echo
echo "=============================================="
echo " Installation completed successfully!"
echo "=============================================="
echo
echo "Application launcher:"
echo "  $DESKTOP_FILE"
echo
echo "Workspace:"
echo "  $WORKSPACE"
echo
echo "Environment file:"
echo "  $ENV_FILE"
echo
echo "You can now launch:"
echo "  Cadence Virtuoso (CMOS 65nm)"
echo
echo "Direct test:"
echo "  $INSTALL_DIR/launch_virtuoso.csh"
