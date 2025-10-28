#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

# Source colors
source "$CONFIG_DIR/colors.sh"

# Get the current focused workspace from Aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Extract workspace number from item name (e.g., "space.1" -> "1")
SPACE_NUM=$(printf "%s" "$NAME" | sed 's/space\.//')

# Apply highlighting based on Aerospace focus only
if [ "$SPACE_NUM" = "$FOCUSED_WORKSPACE" ]; then
  # Focused: filled white circle
  sketchybar --set "$NAME" background.color=$WHITE \
                        background.border_color=$WHITE \
                        drawing=on
else
  # Unfocused: blue fill with white border
  sketchybar --set "$NAME" background.color=$BACKGROUND_1 \
                        background.border_color=$WHITE \
                        drawing=on
fi
