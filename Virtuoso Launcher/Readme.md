
# Cadence Virtuoso Linux Launcher Setup

A step-by-step guide to creating a **native Linux desktop/application launcher** for **Cadence Virtuoso** with automatic environment initialization using **C Shell (`csh`/`tcsh`)**.

This setup allows you to launch Cadence Virtuoso directly from the Linux application menu or desktop without manually opening a terminal, navigating to the project directory, and sourcing the PDK environment file every time.

---

## 📋 Overview

When working with EDA tools such as **Cadence Virtuoso**, the environment usually needs to be initialized before launching the tool.

For example:

```bash
cd ~/Desktop/cmos65
source ./.cshrc_cmos065
virtuoso
```

The `.cshrc_cmos065` file may configure important environment variables such as:

- PDK paths
- Technology files
- Library paths
- License server settings
- Cadence environment variables
- Tool-specific configuration

This guide creates a Linux launcher that automates the complete process.

### Manual Command

The complete process can be executed using:

```bash
csh -c "cd ~/Desktop/cmos65; source ./.cshrc_cmos065; virtuoso"
```

After configuring the launcher, Virtuoso can be started from the **Application Menu** or **Desktop**.

---

# 🛠️ Prerequisites

Before creating the launcher, make sure the following are available.

### Operating System

Any Linux distribution with support for `.desktop` application entries, such as:

- Ubuntu
- Debian
- RHEL
- Rocky Linux
- CentOS
- Fedora
- Other compatible Linux distributions

### Required Shell

Install either:

```text
csh
```

or

```text
tcsh
```

Check whether `csh` is installed:

```bash
which csh
```

If installed, you should get a path similar to:

```text
/bin/csh
```

### Cadence Workspace

The example assumes the Cadence workspace is located at:

```text
~/Desktop/cmos65
```

and contains:

```text
.cshrc_cmos065
```

The directory structure should look approximately like:

```text
~/Desktop/cmos65/
├── .cshrc_cmos065
├── cds.lib
├── launch_virtuoso.csh
└── ...
```

> **Note:** Replace `~/Desktop/cmos65` and `.cshrc_cmos065` with your actual Cadence workspace and environment file if they are different.

---

# 🚀 Setup Methods

There are two recommended approaches.

| Method | Difficulty | Recommended |
|---|---:|---:|
| Direct `.desktop` Launcher | Easy | ⭐⭐⭐ |
| Shell Script Wrapper | Medium | ⭐⭐⭐⭐⭐ |

The **Shell Script Wrapper** is recommended because it keeps the `.desktop` file simple and makes troubleshooting easier.

---

# Method 1 — Direct `.desktop` Launcher

This method creates a Linux application launcher that directly executes the required C-Shell commands.

## 1. Create the launcher

Create the application entry directory if it does not already exist:

```bash
mkdir -p ~/.local/share/applications
```

Then create the launcher:

```bash
nano ~/.local/share/applications/virtuoso-cmos65.desktop
```

---

## 2. Add the launcher configuration

Paste the following:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Cadence Virtuoso (CMOS 65nm)
Comment=Launch Cadence Virtuoso for CMOS 65nm PDK
Exec=/bin/csh -c "cd $HOME/Desktop/cmos65 && source ./.cshrc_cmos065 && virtuoso"
Icon=utilities-terminal
Terminal=true
Categories=Development;Engineering;Electronics;
StartupNotify=true
```

### Important

`$HOME` is used instead of:

```text
~
```

because `~` is not reliably expanded inside the `Exec=` field of a `.desktop` file.

---

## 3. Make the launcher executable

```bash
chmod +x ~/.local/share/applications/virtuoso-cmos65.desktop
```

---

## 4. Update the application database

```bash
update-desktop-database ~/.local/share/applications/
```

You should now be able to find:

```text
Cadence Virtuoso (CMOS 65nm)
```

in your Linux application menu.

---

# Method 2 — Shell Script Wrapper

## ⭐ Recommended

For EDA tools such as Cadence Virtuoso, a wrapper script is generally cleaner and easier to maintain.

Instead of putting the entire command inside the `.desktop` file, the `.desktop` file simply calls a C-Shell script.

The flow becomes:

```text
Linux Application Menu
        │
        ▼
.desktop Launcher
        │
        ▼
launch_virtuoso.csh
        │
        ├── cd ~/Desktop/cmos65
        │
        ├── source .cshrc_cmos065
        │
        └── launch virtuoso
```

---

## 1. Create the launcher script

Create the script inside your Cadence workspace:

```bash
nano ~/Desktop/cmos65/launch_virtuoso.csh
```

Add:

```csh
#!/bin/csh

cd $HOME/Desktop/cmos65
source ./.cshrc_cmos065
virtuoso &
```

---

## 2. Make the script executable

```bash
chmod +x ~/Desktop/cmos65/launch_virtuoso.csh
```

You can verify the permissions with:

```bash
ls -l ~/Desktop/cmos65/launch_virtuoso.csh
```

You should see executable permissions similar to:

```text
-rwxr-xr-x
```

---

## 3. Test the script

Before creating the GUI launcher, test the script directly:

```bash
~/Desktop/cmos65/launch_virtuoso.csh
```

If everything is configured correctly, Cadence Virtuoso should start.

If Virtuoso does not start, fix the command-line setup first before continuing with the `.desktop` launcher.

---

## 4. Create the `.desktop` file

Create:

```bash
nano ~/.local/share/applications/virtuoso-cmos65.desktop
```

Paste:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Cadence Virtuoso (CMOS 65nm)
Comment=Launch Cadence Virtuoso CMOS 65nm Workspace
Exec=/bin/csh -c "$HOME/Desktop/cmos65/launch_virtuoso.csh"
Icon=utilities-terminal
Terminal=false
Categories=Development;Engineering;Electronics;
StartupNotify=true
```

---

## 5. Make the `.desktop` file executable

```bash
chmod +x ~/.local/share/applications/virtuoso-cmos65.desktop
```

---

## 6. Update the application database

```bash
update-desktop-database ~/.local/share/applications/
```

You can now launch Virtuoso from your Linux application menu.

---

# 🖥️ Add the Launcher to the Desktop

If you want the launcher to appear directly on your desktop:

```bash
cp ~/.local/share/applications/virtuoso-cmos65.desktop ~/Desktop/
```

Then make it executable:

```bash
chmod +x ~/Desktop/virtuoso-cmos65.desktop
```

On some Linux desktop environments, you may need to right-click the icon and select:

```text
Allow Launching
```

or:

```text
Trust and Launch
```

The exact wording depends on the desktop environment.

---

# 🔍 Verification

You can validate the `.desktop` file using:

```bash
desktop-file-validate ~/.local/share/applications/virtuoso-cmos65.desktop
```

If there is no output, the file is generally valid.

You can also verify the launcher:

```bash
cat ~/.local/share/applications/virtuoso-cmos65.desktop
```

and verify the C-Shell script:

```bash
cat ~/Desktop/cmos65/launch_virtuoso.csh
```

---

# 🐛 Troubleshooting

| Problem | Possible Cause | Solution |
|---|---|---|
| Launcher does not appear in Application Menu | Application database has not been updated | Run `update-desktop-database ~/.local/share/applications/` |
| Virtuoso does not start | `csh` is missing | Run `which csh` |
| PDK is not loaded | Environment file was not sourced | Check `.cshrc_cmos065` |
| License error | License environment variable is incorrect | Check the license configuration in `.cshrc_cmos065` |
| Wrong working directory | Launcher starts from another directory | Use `cd $HOME/Desktop/cmos65` before sourcing |
| `.desktop` syntax error | Invalid launcher configuration | Run `desktop-file-validate` |
| Terminal closes immediately | Errors are hidden | Temporarily set `Terminal=true` |
| Launcher works in terminal but not GUI | GUI environment differs from terminal environment | Use the wrapper-script method and verify environment variables |
| Desktop icon cannot be launched | Desktop environment does not trust the file | Right-click → **Allow Launching / Trust and Launch** |

---

# 🧪 Debugging the Launcher

If the launcher does not work, temporarily change:

```ini
Terminal=false
```

to:

```ini
Terminal=true
```

This allows you to see terminal output and errors when the launcher runs.

You can also test the exact command manually:

```bash
/bin/csh -c "cd $HOME/Desktop/cmos65 && source ./.cshrc_cmos065 && virtuoso"
```

If this command works but the `.desktop` launcher does not, the problem is most likely related to the desktop-entry configuration rather than Cadence itself.

---

# 📁 Final Directory Structure

After completing the recommended setup, your files should look similar to:

```text
~/Desktop/
│
└── cmos65/
    ├── .cshrc_cmos065
    ├── launch_virtuoso.csh
    ├── cds.lib
    └── ...
```

and:

```text
~/.local/share/applications/
│
└── virtuoso-cmos65.desktop
```

---

# ⚡ Quick Setup

For an already configured Cadence workspace, the essential commands are:

### Create the wrapper

```bash
nano ~/Desktop/cmos65/launch_virtuoso.csh
```

```csh
#!/bin/csh
cd $HOME/Desktop/cmos65
source ./.cshrc_cmos065
virtuoso &
```

Make it executable:

```bash
chmod +x ~/Desktop/cmos65/launch_virtuoso.csh
```

### Create the application launcher

```bash
mkdir -p ~/.local/share/applications
nano ~/.local/share/applications/virtuoso-cmos65.desktop
```

Use:

```ini
[Desktop Entry]
Version=1.0
Type=Application
Name=Cadence Virtuoso (CMOS 65nm)
Comment=Launch Cadence Virtuoso CMOS 65nm Workspace
Exec=/bin/csh -c "$HOME/Desktop/cmos65/launch_virtuoso.csh"
Icon=utilities-terminal
Terminal=false
Categories=Development;Engineering;Electronics;
StartupNotify=true
```

Then:

```bash
chmod +x ~/.local/share/applications/virtuoso-cmos65.desktop
update-desktop-database ~/.local/share/applications/
```

---

# 🎯 Result

After setup, instead of manually running:

```bash
cd ~/Desktop/cmos65
source ./.cshrc_cmos065
virtuoso
```

you can simply open:

**Application Menu → Cadence Virtuoso (CMOS 65nm)**

or use the desktop shortcut.

This makes the Cadence Virtuoso workflow faster and reduces the chance of forgetting to source the required PDK/environment configuration.

---

## 📌 Notes

- The paths in this README are examples and should be changed according to your Cadence installation.
- Make sure your `.cshrc_cmos065` file is valid and can successfully initialize the Cadence environment.
- If your system uses `tcsh` instead of `csh`, replace `/bin/csh` with the appropriate `tcsh` path.
- The **wrapper-script method is recommended** for long-term use because the environment setup remains separate from the GUI launcher configuration.
