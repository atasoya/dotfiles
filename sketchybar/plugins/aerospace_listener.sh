#!/bin/sh

# Poll AeroSpace focused workspace and trigger SketchyBar updates on change

last=""
while true; do
  current=$(aerospace list-workspaces --focused 2>/dev/null)
  if [ -n "$current" ] && [ "$current" != "$last" ]; then
    sketchybar --trigger aerospace_workspace_change --trigger aerospace_focus_change
    last="$current"
  fi
  sleep 0.3
done


