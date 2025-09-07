#!/bin/bash
for dir in autotiling fish kitty nvim rofi sway swaylock waybar zathura; do ln -sfv "$(pwd)/$dir" "$HOME/.config/$dir"; done
for item in .calibre_themes Scripts; do ln -sfv "$(pwd)/$item" "$HOME/$item"; done

# Fedora Workstation Setup Script

echo "Starting Fedora workstation setup..."

# 1. Initial System Update
echo "Updating system packages..."
sudo dnf update -y

# 2. Enable COPR repository and install packages
echo "Enabling nwg-shell repository and installing packages..."
sudo dnf copr enable tofik/nwg-shell
sudo dnf install rofi wdisplays nwg-look neovim sway waybar celluloid \
                 calibre pass rclone rclone-browser libreoffice "*zathura*" \
                 kitty thunar blueman NetworkManager swaylock zoxide fish \
                 dnf-plugins-core tuned -y

# 3. Post-installation configuration
echo "Setting up wallpapers and external software..."
git clone https://github.com/zhichaoh/catppuccin-wallpapers.git
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
sudo dnf config-manager --addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser -y
chsh -s $(which fish)

# 4. Add RPM Fusion repositories
echo "Adding RPM Fusion repositories..."
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf update @core -y

# 5. NVIDIA drivers
echo "Installing NVIDIA drivers..."
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda kmodtool akmods mokutil openssl -y
sudo kmodgenca -a
sudo mokutil --import /etc/pki/akmods/certs/public_key.der

# 6. Multimedia codecs
echo "Installing multimedia codecs..."
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf install intel-media-driver libva-nvidia-driver -y

# 7. Font installation
echo "Installing fonts..."
sudo dnf install google-noto-sans-mono-fonts -y

# 8. Configuration file setup
echo "Setting up configuration files..."
for dir in autotiling fish kitty nvim rofi sway swaylock waybar zathura; do 
    ln -sfv "$(pwd)/$dir" "$HOME/.config/$dir"
done

for item in .calibre_themes Scripts; do 
    ln -sfv "$(pwd)/$item" "$HOME/$item"
done

echo "Setup complete! Please reboot to complete NVIDIA driver installation."
echo "During boot, you will be prompted to enroll the MOK key for Secure Boot."
