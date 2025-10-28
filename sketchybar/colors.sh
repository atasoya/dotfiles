#!/bin/bash

### Kanagawa Color Scheme

# Core Kanagawa tones
export BLACK=0xff1f1f28         # SumiInk1 (dark background)
export WHITE=0xffffffff         # Pure white
export RED=0xffc34043           # Autumn Red
export GREEN=0xff98bb6c         # Spring Green (brighter)
export BLUE=0xff7aa2f7          # Crystal Blue (brighter)
export YELLOW=0xffe6c384        # Carp Yellow (brighter)
export MAGENTA=0xff957fb8       # OniViolet
export CYAN=0xff6a9589          # WaveAqua1
export PURPLE=0xff957fb8        # OniViolet
export GREY=0xff727169          # OldWhite (dim)
export LIGHT_GREY=0xff9cabca    # Light Blue Grey
export DARK_GREY=0xff16161d     # SumiInk0 (darker)
export TRANSPARENT=0x00000000

# Extended Kanagawa palette
export ROSEWATER=0xffd27e99     # Sakura Pink (approx)
export FLAMINGO=0xffe46876      # Peach Red (approx)
export PINK=0xffd27e99          # Sakura Pink
export MAUVE=0xff957fb8         # OniViolet
export LAVENDER=0xff7e9cd8      # Autumn Blue (light)
export TEAL=0xff6a9589          # WaveAqua1
export SAPPHIRE=0xff7fb4ca      # WaveAqua2
export SKY=0xffa3d4d5           # Light Aqua (approx)
export SURFACE0=0xff1f1f28      # SumiInk1
export SURFACE1=0xff2a2a37      # SumiInk2
export SURFACE2=0xff363646      # SumiInk3
export OVERLAY0=0xff54546d      # WaveBlue5 (dim)
export OVERLAY1=0xff7aa2f7      # Crystal Blue (accent)
export OVERLAY2=0xff9cabca      # Light Blue Grey
export SUBTEXT0=0xffc8c093      # Kognac (subtle text)
export SUBTEXT1=0xffdcd7ba      # FujiWhite
export TEXT=0xffffffff          # Pure white (primary text)

# Battery colors using Kanagawa
export BATTERY_1=$GREEN         # Full
export BATTERY_2=$YELLOW        # High
export BATTERY_3=$YELLOW        # Medium
export BATTERY_4=$RED           # Low
export BATTERY_5=0xffc34043     # Critical

# General bar colors (transparent bar, high-contrast text)
export BAR_COLOR=$TRANSPARENT             # Fully transparent bar
export BAR_BORDER_COLOR=0x001f1f28        # No visible border
export BACKGROUND_1=0x337e9cd8            # Autumn Blue tint for pills (translucent)
export BACKGROUND_2=0x99ffffff            # Semi-opaque white border
export ICON_COLOR=$WHITE                  # Full white icons by default
export LABEL_COLOR=$WHITE                 # Full white text by default
export POPUP_BACKGROUND_COLOR=$SURFACE1   # Kanagawa popup background (SumiInk2)
export POPUP_BORDER_COLOR=$BLUE           # Popup border
export SHADOW_COLOR=$DARK_GREY            # Shadow

# Kanagawa accent colors
export ACCENT_PRIMARY=$BLUE               # Autumn Blue
export ACCENT_SECONDARY=$GREEN            # Autumn Green
export ACCENT_TERTIARY=$YELLOW            # Carp Yellow
export ACCENT_QUATERNARY=$MAUVE           # OniViolet
export ACCENT_PINK=$PINK                  # Sakura Pink
