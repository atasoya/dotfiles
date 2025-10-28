#!/usr/bin/env bash

# Source colors for consistent theming
source "$CONFIG_DIR/colors.sh"

# Get battery information
BATTERY_INFO=$(pmset -g batt | grep -Eo "[0-9]+%" | cut -d% -f1)
POWER_SOURCE=$(pmset -g ps | head -1)

# Check if charging
if [[ $POWER_SOURCE == *"AC Power"* ]]; then
    CHARGING=true
else
    CHARGING=false
fi

# Set battery level
BATTERY_LEVEL=$BATTERY_INFO

# Determine icon and color based on battery level and charging status
if [[ $CHARGING == true ]]; then
    ICON="󰂄"  # Charging icon
    COLOR=$WHITE
else
    if [[ $BATTERY_LEVEL -gt 75 ]]; then
        ICON="󰁹"  # Full battery
        COLOR=$WHITE
    elif [[ $BATTERY_LEVEL -gt 50 ]]; then
        ICON="󰁾"  # Three quarters
        COLOR=$WHITE
    elif [[ $BATTERY_LEVEL -gt 25 ]]; then
        ICON="󰁼"  # Half battery
        COLOR=$WHITE
    elif [[ $BATTERY_LEVEL -gt 10 ]]; then
        ICON="󰁻"  # Quarter battery
        COLOR=$WHITE
    else
        ICON="󰁺"  # Empty battery
        COLOR=$WHITE
    fi
fi

# Update the battery item
sketchybar --set "$NAME" icon="$ICON" \
                        icon.color="$COLOR" \
                        icon.font="SF Pro:Semibold:15.0" \
                        icon.y_offset=1 \
                        label="$BATTERY_LEVEL%" \
                        label.color=$WHITE \
                        label.font="Fira Sans:Medium:12.0" \
                        label.y_offset=1
