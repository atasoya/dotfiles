#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

# Get current focused workspace from Aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

# Update all workspaces
update_all_workspaces() {
  # Define the number of workspaces (matching Aerospace config)
  WORKSPACE_COUNT=9
  
  for i in $(seq 1 $WORKSPACE_COUNT); do
    # Highlight focused workspace
    if [ "$i" = "$FOCUSED_WORKSPACE" ]; then
      sketchybar --set space.$i icon.highlight=true \
                         background.border_color=$GREY
    else
      sketchybar --set space.$i icon.highlight=false \
                         background.border_color=$BACKGROUND_2
    fi
  done
}

if [ "$SENDER" = "space_change" ] || [ "$SENDER" = "window_change" ] || [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "aerospace_focus_change" ]; then
  update_all_workspaces
fi
