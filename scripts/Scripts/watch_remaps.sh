#!/bin/bash

# First apply the remap
~/Scripts/remap_keys.sh

# Watch loop
while true; do
    sleep 1

    # Check if mappings are still in place (Escape still mapped to Caps_Lock?)
    if ! xmodmap -pke | grep -q 'keycode *9 *= *Caps_Lock'; then
        echo "[remap] Keyboard remapping lost. Reapplying..."
        ~/Scripts/remap_keys.sh
    fi
done

