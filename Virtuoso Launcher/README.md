# Cadence Virtuoso Linux Launcher

A portable Linux launcher for **Cadence Virtuoso** that automatically changes to your Cadence workspace, sources your C-Shell environment file, launches Virtuoso, and creates a Linux application-menu entry.

## Repository Structure

```text
cadence-virtuoso-launcher/
├── README.md
├── install.sh
├── launch_virtuoso.csh
└── virtuoso-cmos65.desktop
```

## Requirements

- Linux
- Cadence Virtuoso already installed/configured
- `csh` or `tcsh`
- A Cadence workspace
- A C-Shell environment file such as `.cshrc_cmos065`

Check C Shell:

```bash
which csh
```

or:

```bash
which tcsh
```

## Quick Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/cadence-virtuoso-launcher.git
cd cadence-virtuoso-launcher
chmod +x install.sh
./install.sh
```

The installer asks for:

1. Cadence workspace path
2. Environment file name
3. Whether to create a desktop shortcut

Example:

```text
Cadence workspace directory [/home/user/Desktop/cmos65]:
Environment file [.cshrc_cmos065]:
Create a desktop shortcut? [Y/n]:
```

After installation, launch:

**Application Menu → Cadence Virtuoso (CMOS 65nm)**

## How It Works

```text
Linux Application Menu
        │
        ▼
virtuoso-cmos65.desktop
        │
        ▼
launch_virtuoso.csh
        │
        ├── cd to Cadence workspace
        ├── source .cshrc_cmos065
        └── start Virtuoso
```

The equivalent terminal workflow is:

```bash
cd ~/Desktop/cmos65
source ./.cshrc_cmos065
virtuoso
```

## Manual Installation

Edit:

```bash
nano launch_virtuoso.csh
```

Configure:

```csh
set WORKSPACE = "$HOME/Desktop/cmos65"
set ENV_FILE = ".cshrc_cmos065"
```

Then:

```bash
chmod +x launch_virtuoso.csh
./launch_virtuoso.csh
```

If Virtuoso starts correctly, install the application entry:

```bash
mkdir -p ~/.local/share/applications
cp virtuoso-cmos65.desktop ~/.local/share/applications/
chmod +x ~/.local/share/applications/virtuoso-cmos65.desktop
update-desktop-database ~/.local/share/applications/ 2>/dev/null || true
```

> For manual installation, edit the `Exec=` path in `virtuoso-cmos65.desktop` to point to your launcher script.

## Troubleshooting

### Virtuoso does not start

Test:

```bash
./launch_virtuoso.csh
```

Then test manually:

```bash
cd ~/Desktop/cmos65
csh
source ./.cshrc_cmos065
virtuoso
```

If this fails, the issue is likely with the Cadence/PDK environment rather than the launcher.

### `csh: command not found`

Install C Shell using your distribution's package manager.

For Ubuntu/Debian:

```bash
sudo apt install csh
```

### Launcher does not appear

Run:

```bash
update-desktop-database ~/.local/share/applications/
```

### Desktop icon is untrusted

Right-click the `.desktop` file and select **Allow Launching**, **Trust and Launch**, or the equivalent option for your desktop environment.

### Need to see terminal errors

Temporarily change:

```ini
Terminal=false
```

to:

```ini
Terminal=true
```

## Uninstall

Remove the application entry:

```bash
rm -f ~/.local/share/applications/virtuoso-cmos65.desktop
```

If a desktop shortcut was created:

```bash
rm -f ~/Desktop/virtuoso-cmos65.desktop
```

## Notes

This project does **not** install Cadence Virtuoso, a PDK, or license files. It only automates initialization of an existing Cadence environment.

Do not upload proprietary Cadence files, PDKs, or license information to GitHub.

## License

The launcher configuration is provided for personal and educational use. Cadence Virtuoso and associated PDKs are proprietary software and are not included in this repository.
