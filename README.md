# Fedora Workstation Setup Guide

This guide provides a set of commands to configure a Fedora workstation, including system updates, application installation, third-party repositories, NVIDIA drivers, and multimedia codecs.

## 1. Initial System Update & Core Packages

First, update all existing system packages to their latest versions.

```bash
sudo dnf update -y
```

Next, enable the necessary COPR repository for `nwg-shell` and install a curated list of applications and tools.

```bash
# Enable the nwg-shell repository
sudo dnf copr enable tofik/nwg-shell

# Install essential applications and utilities
sudo dnf install rofi wdisplays nwg-look neovim sway waybar celluloid \
                 calibre pass rclone rclone-browser libreoffice "*zathura*" \
                 kitty thunar blueman NetworkManager swaylock zoxide fish \
                 dnf-plugins-core tuned
```

## 2. Post-Installation Configuration

These commands handle setting up wallpapers, installing software from external sources, and changing the default shell.

```bash
# Clone a wallpaper pack
git clone https://github.com/zhichaoh/catppuccin-wallpapers.git

# Install the latest version of Calibre via its official installer
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Add the Brave Browser repository and install it
sudo dnf config-manager --addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser

# Change the default user shell to Fish
chsh -s $(which fish)
```

## 3. Add RPM Fusion Repositories

RPM Fusion provides software that Fedora cannot ship due to licensing or patent reasons. It's essential for multimedia codecs and proprietary drivers.

```bash
# Add both free and non-free repositories
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update core packages with the new repositories enabled
sudo dnf update @core
```

## 4. NVIDIA Driver Installation

These steps install the proprietary NVIDIA drivers.

**Important:** The `mokutil` command is for enrolling a new MOK (Machine Owner Key) for Secure Boot. After running the import command, you **must reboot** your machine. During the boot process, you will be prompted to enroll the key. Select "Enroll MOK" and follow the on-screen instructions. You will need to create a password when prompted.

```bash
# Install the driver and CUDA support
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda

# Tools for kernel module signing
sudo dnf install kmodtool akmods mokutil openssl

# Generate and import the key for Secure Boot
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der
```

## 5. Multimedia Codecs & Drivers

Install full multimedia support by swapping out the default `ffmpeg` and adding drivers.

```bash
# Swap the default FFMPEG for the full version from RPM Fusion
sudo dnf swap ffmpeg-free ffmpeg --allowerasing

# Install multimedia codecs and plugins
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin

# Install hardware-specific video acceleration drivers
sudo dnf install intel-media-driver
sudo dnf install libva-nvidia-driver
```

## 6. Font Installation

Install the Noto Sans Mono font from the Google Noto family.

```bash
sudo dnf install google-noto-sans-mono-fonts
```
