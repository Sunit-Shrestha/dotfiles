#!/bin/bash

# Try to find a Konsole window that is currently running yazi
win_id=$(xdotool search --onlyvisible --class konsole)

for id in $win_id; do
    # Get the process ID of the window
    pid=$(xdotool getwindowpid "$id")

    # Check if 'yazi' is one of the subprocesses of that PID
    if pstree -p "$pid" | grep -q "yazi"; then
        # Yazi is running inside this Konsole window — focus it
        xdotool windowactivate "$id"
        exit 0
    fi
done

# Yazi not running — launch it in a new Konsole window
konsole --noclose -e yazi &
