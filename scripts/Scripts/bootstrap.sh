#!/bin/bash

# Download Arch packages
sudo pacman -S --needed - < pacmanlist.txt
yay -S --needed - < aurlist.txt

# Create base python virtual environment
uv venv --python 3.12.10 ~/.uv/base/
source ~/.uv/base/bin/activate
uv pip install -r requirements.txt
deactivate

# Yazi plugins
ya pkg add dedukun/relative-motions
ya pkg add yazi-rs/plugins:jump-to-char

# KDE Themes
plasma-apply-colorscheme Dracula
plasma-apply-cursortheme Breeze_Light
plasma-apply-desktoptheme default
papirus-folders --color bluegrey
kwriteconfig5 --file kdeglobals --group Icons --key Theme Papirus
kquitapp5 plasmashell && kstart5 plasmashell
