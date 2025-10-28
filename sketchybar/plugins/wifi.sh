#!/usr/bin/env bash

# Source colors for consistent theming and icons
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Multiple methods to detect WiFi status
WIFI_CONNECTED=false
WIFI_SSID=""

# Check only WiFi interfaces - avoid VPN interfaces
# First, find which interfaces are actually WiFi capable
WIFI_INTERFACES=$(networksetup -listallhardwareports | grep -A 1 "Wi-Fi" | grep "Device:" | awk '{print $2}' 2>/dev/null)

# If no WiFi interfaces found via networksetup, try common ones
if [[ -z "$WIFI_INTERFACES" ]]; then
    WIFI_INTERFACES="en0"
fi

for interface in $WIFI_INTERFACES; do
    if [[ -n "$interface" ]]; then
        # Check if this is actually a WiFi interface
        WIFI_INFO=$(networksetup -getairportnetwork "$interface" 2>/dev/null)
        if [[ "$WIFI_INFO" != *"not found"* ]] && [[ "$WIFI_INFO" != *"is not a Wi-Fi interface"* ]] && [[ -n "$WIFI_INFO" ]]; then
            # This is a WiFi interface, check if connected
            if [[ "$WIFI_INFO" != *"You are not associated"* ]]; then
                WIFI_SSID=$(echo "$WIFI_INFO" | sed 's/Current Wi-Fi Network: //' | xargs)
                WIFI_CONNECTED=true
                break
            fi
        fi
    fi
done

# Method 2: Try scutil to get WiFi network name (avoid VPN services)
if [[ "$WIFI_CONNECTED" == false || -z "$WIFI_SSID" ]]; then
    # Get all network services and find WiFi ones
    SCUTIL_SERVICES=$(scutil --nc list | grep -E "(Wi-Fi|AirPort)" | head -1)
    if [[ -n "$SCUTIL_SERVICES" ]]; then
        # Extract service ID for WiFi
        WIFI_SERVICE_ID=$(echo "$SCUTIL_SERVICES" | sed 's/.*(\([^)]*\)).*/\1/')
        if [[ -n "$WIFI_SERVICE_ID" ]]; then
            NETWORK_INFO=$(echo "show State:/Network/Service/$WIFI_SERVICE_ID/Airport" | scutil | grep "SSID_STR" | awk '{print $3}')
            if [[ -n "$NETWORK_INFO" ]]; then
                WIFI_SSID="$NETWORK_INFO"
                WIFI_CONNECTED=true
            fi
        fi
    fi
fi

# Method 3: Try airport command if available  
if [[ "$WIFI_CONNECTED" == false || -z "$WIFI_SSID" ]]; then
    if command -v airport >/dev/null 2>&1; then
        AIRPORT_INFO=$(airport -I 2>/dev/null | grep -w SSID | awk '{print $2}')
        if [[ -n "$AIRPORT_INFO" ]]; then
            WIFI_SSID="$AIRPORT_INFO"
            WIFI_CONNECTED=true
        fi
    fi
fi

# Method 4: Try system_profiler for detailed network info
if [[ "$WIFI_CONNECTED" == false || -z "$WIFI_SSID" ]]; then
    # Extract the actual network name from system_profiler
    NETWORK_NAME=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Current Network Information:/{getline; if(/^ *[A-Za-z]/) {gsub(/^ */, ""); gsub(/:.*/, ""); print; exit}}')
    if [[ -n "$NETWORK_NAME" && "$NETWORK_NAME" != "Network" && "$NETWORK_NAME" != "Current" ]]; then
        WIFI_SSID="$NETWORK_NAME"
        WIFI_CONNECTED=true
    fi
fi

# Final fallback: Check if we have internet and show interface name (avoid VPN)
if [[ "$WIFI_CONNECTED" == false ]]; then
    if ping -c 1 -W 1000 google.com >/dev/null 2>&1; then
        # Check if we have a WiFi interface with IP (not VPN)
        for interface in $WIFI_INTERFACES; do
            WIFI_IP=$(ifconfig "$interface" 2>/dev/null | grep "inet " | awk '{print $2}' | head -1)
            if [[ -n "$WIFI_IP" && "$WIFI_IP" != "127.0.0.1" ]]; then
                WIFI_CONNECTED=true
                WIFI_SSID="WiFi Connected"
                break
            fi
        done
    fi
fi

# Detect VPN connection and get protocol name
VPN_CONNECTED=false
VPN_PROTOCOL=""

# Mullvad CLI (if installed)
if command -v mullvad >/dev/null 2>&1; then
    MULLVAD_STATUS=$(mullvad status 2>/dev/null)
    if echo "$MULLVAD_STATUS" | grep -qi "connected"; then
        VPN_CONNECTED=true
        VPN_PROTOCOL="Mullvad"
    fi
fi

# Check for WireGuard interfaces
if [[ "$VPN_CONNECTED" == false ]]; then
    DEFAULT_IFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
    if [[ "$DEFAULT_IFACE" == utun* ]]; then
        VPN_CONNECTED=true
        VPN_PROTOCOL="WireGuard"
    fi
fi

# Check for OpenVPN connections
if [[ "$VPN_CONNECTED" == false ]]; then
    OPENVPN_PROCESSES=$(ps aux | grep -i openvpn | grep -v grep)
    if [[ -n "$OPENVPN_PROCESSES" ]]; then
        VPN_CONNECTED=true
        VPN_PROTOCOL="OpenVPN"
    fi
fi

# Check for other VPN services using scutil
if [[ "$VPN_CONNECTED" == false ]]; then
    VPN_SERVICES=$(scutil --nc list 2>/dev/null | grep -E "(Connected|VPN)" | grep -v "Wi-Fi")
    if [[ -n "$VPN_SERVICES" ]]; then
        VPN_CONNECTED=true
        # Try to extract VPN service name
        VPN_SERVICE_NAME=$(echo "$VPN_SERVICES" | head -1 | sed 's/.*(\([^)]*\)).*/\1/' | sed 's/.*: //')
        if [[ -n "$VPN_SERVICE_NAME" ]]; then
            VPN_PROTOCOL="$VPN_SERVICE_NAME"
        else
            VPN_PROTOCOL="VPN"
        fi
    fi
fi

# Set icon and color based on VPN/WiFi status
if [[ "$VPN_CONNECTED" == true ]]; then
    ICON="$LOCK"
    COLOR=$WHITE
else
    if [[ "$WIFI_CONNECTED" == true ]]; then
        ICON="󰤨"
        COLOR=$WHITE
    else
        ICON="󰤭"
        COLOR=$WHITE
    fi
fi

# Update the WiFi item - show lock icon with WiFi name when VPN connected, WiFi normally otherwise
if [[ "$VPN_CONNECTED" == true ]]; then
    # Show lock icon with WiFi network name when VPN is connected (same positioning as main config)
    sketchybar --set "$NAME" icon="$ICON" \
                            icon.color="$COLOR" \
                            icon.font="Hack Nerd Font Mono:Bold:15.0" \
                            icon.padding_left=8 \
                            icon.padding_right=6 \
                            icon.y_offset=1 \
                            label="$WIFI_SSID" \
                            label.color="$WHITE" \
                            label.font="Fira Sans:Medium:12.0" \
                            label.padding_left=4 \
                            label.padding_right=8 \
                            label.y_offset=1 \
                            label.drawing=on
elif [[ "$WIFI_CONNECTED" == true && -n "$WIFI_SSID" ]]; then
    # Show WiFi normally when not connected to VPN (same positioning as main config)
    sketchybar --set "$NAME" icon="$ICON" \
                            icon.color="$COLOR" \
                            icon.font="SF Pro:Semibold:15.0" \
                            icon.padding_left=8 \
                            icon.padding_right=6 \
                            icon.y_offset=1 \
                            label="$WIFI_SSID" \
                            label.color="$WHITE" \
                            label.font="Fira Sans:Medium:12.0" \
                            label.padding_left=4 \
                            label.padding_right=8 \
                            label.y_offset=1 \
                            label.drawing=on
else
    # Show only disconnected icon (same positioning as main config)
    sketchybar --set "$NAME" icon="$ICON" \
                            icon.color="$COLOR" \
                            icon.font="SF Pro:Semibold:15.0" \
                            icon.padding_left=8 \
                            icon.padding_right=6 \
                            icon.y_offset=1 \
                            label="Disconnected" \
                            label.color="$WHITE" \
                            label.font="Fira Sans:Medium:12.0" \
                            label.padding_left=4 \
                            label.padding_right=8 \
                            label.y_offset=1 \
                            label.drawing=on
fi
