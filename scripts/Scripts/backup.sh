#!/bin/bash

cd ~/Scripts

# Backup packages
pacman -Qe | awk '{print $1}' > all-explicit.txt
pacman -Qem | awk '{print $1}' > aurlist.txt
comm -23 <(sort all-explicit.txt) <(sort aurlist.txt) > pacmanlist.txt
rm all-explicit.txt

# Backup system units
systemctl list-unit-files --state=enabled --no-legend \
  | awk '{print $1}' \
  | sort -u \
  > system-units.txt

# Backup user units
systemctl --user list-unit-files --state=enabled --no-legend \
  | awk '{print $1}' \
  | sort -u \
  > user-units.txt

# Backup python packages
source ~/.uv/base/bin/activate
uv pip freeze > requirements.txt
