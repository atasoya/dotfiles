#!/usr/bin/env bash

# Source colors for consistent theming
source "$CONFIG_DIR/colors.sh"

# Get current time and date
TIME=$(date "+%I:%M %p")
DATE=$(date "+%a %d %b")

# Format the label with both time and date
LABEL="$TIME  $DATE"

# Set the clock with enhanced styling
sketchybar --set "$NAME" label="$LABEL" \
                        icon="󰅐" \
                        icon.color=$WHITE \
                        icon.font="SF Pro:Semibold:15.0" \
                        icon.y_offset=1 \
                        label.color=$WHITE \
                        label.font="Fira Sans:Medium:12.0" \
                        label.y_offset=1

