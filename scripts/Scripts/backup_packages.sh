#!/bin/bash

cd ~/Scripts
pacman -Qe > all-explicit.txt
pacman -Qm > aurlist.txt
comm -23 <(sort all-explicit.txt) <(sort aurlist.txt) > pacmanlist.txt
rm all-explicit.txt
