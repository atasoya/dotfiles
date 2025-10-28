#!/usr/bin/env bash

# Source colors for consistent theming
source "$CONFIG_DIR/colors.sh"

# Check for VPN connection
VPN_CONNECTED=false
VPN_NAME=""

# Method 1: Check for Mullvad processes specifically
MULLVAD_PROCESSES=$(ps aux | grep -i mullvad | grep -v grep)
if [[ -n "$MULLVAD_PROCESSES" ]]; then
    # Check if Mullvad is actually connected (not just running)
    MULLVAD_STATUS=$(mullvad status 2>/dev/null | grep -i "connected")
    if [[ -n "$MULLVAD_STATUS" ]]; then
        VPN_CONNECTED=true
        VPN_NAME="Mullvad"
    fi
fi

# Method 2: Check for WireGuard interfaces (Mullvad uses WireGuard)
if [[ "$VPN_CONNECTED" == false ]]; then
    WG_INTERFACES=$(ifconfig | grep "utun" | awk '{print $1}' | sed 's/://')
    for interface in $WG_INTERFACES; do
        if [[ -n "$interface" ]]; then
            VPN_IP=$(ifconfig "$interface" 2>/dev/null | grep "inet " | awk '{print $2}' | head -1)
            if [[ -n "$VPN_IP" && "$VPN_IP" != "127.0.0.1" ]]; then
                # Double-check this is actually a VPN by checking if it's in the routing table
                ROUTE_CHECK=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
                if [[ "$ROUTE_CHECK" == "$interface" ]]; then
                    VPN_CONNECTED=true
                    VPN_NAME="WireGuard"
                    break
                fi
            fi
        fi
    done
fi

# Method 3: Check for VPN services using scutil (but be more specific)
if [[ "$VPN_CONNECTED" == false ]]; then
    VPN_SERVICES=$(scutil --nc list | grep -E "(Connected|Mullvad|WireGuard)" | grep -v "Wi-Fi")
    if [[ -n "$VPN_SERVICES" ]]; then
        VPN_CONNECTED=true
        VPN_NAME="VPN"
    fi
fi

# Set icon and color based on VPN status
if [[ "$VPN_CONNECTED" == true ]]; then
    # VPN is connected - green icon
    ICON="󰌾"
    COLOR=$ACCENT_SECONDARY  # Green
    LABEL="$VPN_NAME"
else
    # VPN is disconnected - gray icon
    ICON="󰌾"
    COLOR=$GREY
    LABEL="No VPN"
fi

# Update the VPN item with clear status
if [[ "$VPN_CONNECTED" == true ]]; then
    sketchybar --set "$NAME" icon="$ICON" \
                            icon.color="$COLOR" \
                            label="$VPN_NAME" \
                            label.color="$WHITE" \
                            label.drawing=on
else
    sketchybar --set "$NAME" icon="$ICON" \
                            icon.color="$COLOR" \
                            label="Disconnected" \
                            label.color="$WHITE" \
                            label.drawing=on
fi

