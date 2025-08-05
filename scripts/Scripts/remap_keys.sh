#!/bin/bash

setxkbmap -layout us
xmodmap -e "keycode 66 = Hyper_L"
xmodmap -e "clear lock"
xmodmap -e "clear control"
xmodmap -e "add Control = Control_L Hyper_L"
xmodmap -e "keycode 9 = Caps_Lock"
xmodmap -e "keycode 255 = Escape"
pkill xcape
xcape -e 'Hyper_L=Escape' &
