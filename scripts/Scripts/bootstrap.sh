#!/bin/bash

# Download Arch packages
# Enable multilib in /etc/pacman.conf first
sudo pacman -S --needed - < ~/.dotfiles/scripts/Scripts/pacmanlist.txt

# Yay and AUR Setup
cd ~
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
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
