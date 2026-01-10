#!/bin/bash

# Check minimum number of arguments
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <workspace_number> <window_class> <window_title> [focus_flag] <cli_command...>"
    exit 1
fi

# Fixed arguments
WORKSPACE="$1"
WINDOW_CLASS="$2"
WINDOW_TITLE="$3"
shift 3

# Optional focus flag
FOCUS_FLAG="false"
if [[ "$1" == "true" || "$1" == "false" ]]; then
    FOCUS_FLAG="$1"
    shift
fi

# Remaining arguments are the CLI command
if [ "$#" -eq 0 ]; then
    echo "Error: No CLI command provided"
    exit 1
fi

CLI_COMMAND=("$@")

# Switch to the specified workspace
wmctrl -s "$WORKSPACE"

# Find window (exact class, partial title)
WINDOW_ID=$(wmctrl -lx | awk -v class="$WINDOW_CLASS" -v title="$WINDOW_TITLE" \
    '$3 == class && substr($0, index($0,$4)) ~ title {print $1; exit}')

if [ -z "$WINDOW_ID" ]; then
    echo "No matching window found, running CLI command: ${CLI_COMMAND[*]}"
    "${CLI_COMMAND[@]}"
else
    if [ "$FOCUS_FLAG" == "true" ]; then
        echo "Found window with ID: $WINDOW_ID, focusing..."
        wmctrl -i -a "$WINDOW_ID"
    else
        echo "Window found, but focus is not requested."
    fi
fi
