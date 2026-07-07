#!/bin/bash

set -e

# Download Arch packages and setup AUR
# NOTE: Enable multilib in /etc/pacman.conf first
# 1. Setup Arch Linux CN
sudo echo -e "\n[archlinuxcn]\nInclude = /etc/pacman.d/archlinuxcn-mirrorlist" >> /etc/pacman.conf
sudo echo 'Server = https://repo.archlinuxcn.org/$arch' > /etc/pacman.d/archlinuxcn-mirrorlist
sudo pacman -Syyu
sudo pacman -S archlinuxcn-keyring
# 2. Setup Chaotic AUR
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf
sudo pacman -Syu
# 3. Installation
sudo pacman -S --needed - < ~/.dotfiles/scripts/Scripts/pacmanlist.txt
yay -S --needed - < ~/.dotfiles/scripts/Scripts/aurlist.txt
# 4. Update mirrorlist
rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist
rate-mirrors archlinuxcn | sudo tee /etc/pacman.d/archlinuxcn-mirrorlist
rate-mirrors chaotic-aur | sudo tee /etc/pacman.d/chaotic-mirrorlist

# Create base python virtual environment
uv venv --python 3.12.10 ~/.uv/base/
source ~/.uv/base/bin/activate
uv pip install -r ~/.dotfiles/scripts/Scripts/requirements.txt
deactivate

# Input Customization Prerequisites (For Kanata and Fusuma)
# For details visit https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md
sudo groupdel uinput 2>/dev/null
sudo groupadd --system uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo modprobe uinput
sudo tee /etc/udev/rules.d/99-input.rules > /dev/null <<EOF
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger

# Kanata Setup
ln -s ~/.dotfiles/kanata/.config/kanata/kanata.service ~/.config/systemd/user/kanata.service
systemctl --user enable --now kanata.service

# Touchpad Gestures Setup
qdbus6 org.kde.KWin /Effects org.kde.kwin.Effects.loadEffect kwin_gestures
sudo ln -s ~/.dotfiles/fusuma/.config/fusuma/ydotool.service /etc/systemd/system/ydotool.service
sudo systemctl enable --now ydotool.service
ln -s ~/.dotfiles/fusuma/.config/fusuma/fusuma.service ~/.config/systemd/user/fusuma.service
systemctl --user enable --now fusuma.service

# App Switcher
ln -s ~/.dotfiles/app-switcher/.config/app-switcher/app-launcher.service ~/.local/share/dbus-1/services/com.user.DesktopLauncher.service
kwriteconfig6 \                                                                  
  --file kwinrc \
  --group Plugins \
  --key app-switcherEnabled true 
qdbus org.kde.KWin /KWin reconfigure

# Vicinae Setup
systemctl --user enable --now vicinae.service

# Enable units and services
while read -r unit; do
    sudo systemctl enable "$unit"
done < "$HOME/.dotfiles/scripts/Scripts/system-units.txt"

while read -r unit; do
    systemctl --user enable "$unit"
done < "$HOME/.dotfiles/scripts/Scripts/user-units.txt"

# KDE Themes
plasma-apply-colorscheme Dracula
plasma-apply-cursortheme Breeze_Light
plasma-apply-desktoptheme default
papirus-folders --color bluegrey
kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus
kquitapp6 plasmashell && kstart plasmashell

# NOTE: Restart after running
