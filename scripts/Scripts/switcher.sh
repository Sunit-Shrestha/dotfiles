#!/bin/bash

# Check if correct number of arguments are provided
if [ "$#" -lt 4 ]; then
    echo "Usage: $0 <workspace_number> <window_class> <window_title> <cli_command> [focus_flag]"
    exit 1
fi

# Parse the arguments
WORKSPACE="$1"
WINDOW_CLASS="$2"
WINDOW_TITLE="$3"
CLI_COMMAND="$4"
FOCUS_FLAG="${5:-false}"  # Default to false if not provided

# Switch to the specified workspace
wmctrl -s "$WORKSPACE"

# Try to find the window based on exact class match and partial title match
WINDOW_ID=$(wmctrl -lx | awk -v class="$WINDOW_CLASS" -v title="$WINDOW_TITLE" \
    '$3 == class && substr($0, index($0,$4)) ~ title {print $1; exit}')

if [ -z "$WINDOW_ID" ]; then
    # If no such window exists, run the provided CLI command
    echo "No matching window found, running CLI command: $CLI_COMMAND"
    $CLI_COMMAND
else
    # If window is found and focus_flag is true, focus the window
    if [ "$FOCUS_FLAG" == "true" ]; then
        echo "Found window with ID: $WINDOW_ID, focusing..."
        wmctrl -i -a "$WINDOW_ID"
    else
        echo "Window found, but focus is not requested."
    fi
fi
