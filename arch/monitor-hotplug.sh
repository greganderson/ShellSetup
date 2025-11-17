#!/usr/bin/env bash
# ~/.config/hypr/monitor-hotplug.sh
# Detect HDMI presence and set eDP-2 resolution/scale accordingly.

set -euo pipefail

INTERNAL="eDP-2"
EXTERNAL="HDMI-A-1"

# Laptop display when HDMI is plugged in
INTERNAL_HDMI_RES="1920x1080@60"
INTERNAL_HDMI_POS="0x0"
INTERNAL_HDMI_SCALE="1.60"

# Default (normal) settings for internal when HDMI not connected
INTERNAL_DEFAULT_RES="preferred"
INTERNAL_DEFAULT_POS="0x0"
INTERNAL_DEFAULT_SCALE="1.60"

# HDMI
EXTERNAL_RES="preferred"
EXTERNAL_POS="0x0"
EXTERNAL_SCALE="1.60"

# helper to run hyprctl safely
hyprctl_keyword() {
  # hyprctl keyword "monitor" "<monitor-line>"
  # Use --batch when you might send multiple commands in quick succession.
  hyprctl --batch keyword monitor "$1"
}

# Check presence: list active monitors and search for EXTERNAL name.
if hyprctl monitors all | grep -q "^$EXTERNAL\| $EXTERNAL "; then
  echo "$(date) - external $EXTERNAL detected -> applying HDMI profile"
  # Set the external monitor
  hyprctl_keyword "${EXTERNAL}, ${EXTERNAL_RES}, ${EXTERNAL_POS}, ${EXTERNAL_SCALE}, mirror, ${INTERNAL}"
  # Set internal to the HDMI-targeted resolution & scale and mirror
  hyprctl_keyword "${INTERNAL}, ${INTERNAL_HDMI_RES}, ${INTERNAL_HDMI_POS}, ${INTERNAL_HDMI_SCALE}"
else
  echo "$(date) - external $EXTERNAL not detected -> restoring default profile"
  # Restore internal to default
  hyprctl_keyword "${INTERNAL}, ${INTERNAL_DEFAULT_RES}, ${INTERNAL_DEFAULT_POS}, ${INTERNAL_DEFAULT_SCALE}"
  # Optionally remove or set external to disabled (no-op if absent)
  # hyprctl_keyword "${EXTERNAL}, off, auto, 1"
fi

