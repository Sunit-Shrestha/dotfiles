#!/bin/bash

cd ~/Scripts
pacman -Qe | awk '{print $1}' > all-explicit.txt
pacman -Qm | awk '{print $1}' > aurlist.txt
comm -23 <(sort all-explicit.txt) <(sort aurlist.txt) > pacmanlist.txt
rm all-explicit.txt
