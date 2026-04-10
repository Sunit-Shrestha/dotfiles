#!/bin/bash

# Download Arch packages and setup AUR
# Enable multilib in /etc/pacman.conf first
# 1. Setup Arch Linux CN
sudo echo -e '\n[archlinuxcn]\nServer = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf
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

# Create base python virtual environment
uv venv --python 3.12.10 ~/.uv/base/
source ~/.uv/base/bin/activate
uv pip install -r requirements.txt
deactivate

# Kanata Setup
sudo groupadd uinput
sudo usermod -aG uinput $USER
mkdir -p ~/.config/systemd/user/
cp ~/.config/kanata/kanata.service ~/.config/systemd/user/
systemctl --user enable --now kanata.service

# KDE Themes
plasma-apply-colorscheme Dracula
plasma-apply-cursortheme Breeze_Light
plasma-apply-desktoptheme default
papirus-folders --color bluegrey
kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus
kquitapp6 plasmashell && kstart plasmashell
