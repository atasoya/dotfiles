#!/usr/bin/env bash

# Source colors for proper styling
source "/Users/atasoyata/.config/sketchybar/colors.sh"

# Get the current focused workspace from Aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Extract workspace number from item name (e.g., "space.1" -> "1")
SPACE_NUM=$(printf "%s" "$NAME" | sed 's/space\.//')

# Apply highlighting based on Aerospace focus
if [ "$SPACE_NUM" = "$FOCUSED_WORKSPACE" ]; then
    # Focused: filled white circle
    sketchybar --set "$NAME" background.color=$WHITE \
                          background.border_color=$WHITE \
                          background.drawing=on
else
    # Unfocused: blue fill with white border
    sketchybar --set "$NAME" background.color=$BACKGROUND_1 \
                          background.border_color=0xccffffff \
                          background.drawing=on
fi
