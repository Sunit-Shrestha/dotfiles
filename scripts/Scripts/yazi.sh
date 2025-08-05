#!/bin/bash

# Find visible Kitty windows
# win_ids=$(xdotool search --onlyvisible --class kitty)
#
# for id in $win_ids; do
#     # Get PID of the window
#     pid=$(xdotool getwindowpid "$id")
#
#     # Check if 'yazi' is a subprocess of this PID
#     if pstree -p "$pid" | grep -q "yazi"; then
#         # Found a Kitty window running yazi — focus it
#         xdotool windowactivate "$id"
#         exit 0
#     fi
# done

# If not found, launch yazi in a new Kitty window
kitty --hold --override confirm_os_window_close=0 -e yazi &
