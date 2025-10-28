#!/bin/sh

# Source colors and variables
source "$CONFIG_DIR/colors.sh"

# Aerospace workspace integration using built-in event system
sketchybar --add event aerospace_workspace_change

# Get all aerospace workspaces dynamically
for sid in $(aerospace list-workspaces --all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        icon.drawing=off \
        label=" " \
        label.color=0x00ffffff \
        label.drawing=on \
        drawing=on \
        padding_left=4 \
        padding_right=4 \
        background.color=$BACKGROUND_1 \
        background.border_color=0xccffffff \
        background.border_width=3 \
        background.corner_radius=3 \
        background.height=14 \
        background.width=20 \
        background.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"
done

space_creator=(
  icon=">"
  icon.font="Fira Sans:Bold:16.0"
  icon.color=$WHITE
  icon.y_offset=0
  padding_left=10
  padding_right=2
  label.drawing=off
  display=active
  script="$PLUGIN_DIR/space_windows.sh"
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_change window_change
