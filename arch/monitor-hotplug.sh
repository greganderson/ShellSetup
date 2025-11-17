#!/usr/bin/env bash
set -euo pipefail

################################
# Configuration
################################

INTERNAL="eDP-2"
EXTERNAL="HDMI-A-1"

# Laptop display when HDMI is plugged in
INTERNAL_HDMI_RES="1920x1080@60"
INTERNAL_HDMI_POS="0x0"
INTERNAL_HDMI_SCALE="1.60"

# Normal settings for internal when HDMI is not connected
INTERNAL_DEFAULT_RES="preferred"
INTERNAL_DEFAULT_POS="0x0"
INTERNAL_DEFAULT_SCALE="1.60"

# HDMI settings
EXTERNAL_RES="preferred"
EXTERNAL_POS_PLUGGED_IN="0x0"
# 1600x0 instead of 2560x0 because the internal display is scaled by 1.6
EXTERNAL_POS_NOT_PLUGGED_IN="1600x0"
EXTERNAL_SCALE="1.60"


################################
# Helpers
################################

hyprctl_keyword() {
  # hyprctl keyword "monitor" "<monitor-line>"
  hyprctl --batch keyword monitor "$1"
}

hdmi_present() {
  hyprctl monitors all | grep -q "^$EXTERNAL\| $EXTERNAL "
}


################################
# Actions
################################

start() {
  echo "$(date) - starting mirror of main display..."

  if hdmi_present; then
    echo "$(date) - external $EXTERNAL detected -> applying HDMI profile"

    # Set external
    hyprctl_keyword "${EXTERNAL}, ${EXTERNAL_RES}, ${EXTERNAL_POS_PLUGGED_IN}, ${EXTERNAL_SCALE}, mirror, ${INTERNAL}"

    # Set internal when HDMI is active
    hyprctl_keyword "${INTERNAL}, ${INTERNAL_HDMI_RES}, ${INTERNAL_HDMI_POS}, ${INTERNAL_HDMI_SCALE}"
  else
    echo "$(date) - external $EXTERNAL not detected -> restoring default profile"

    # Restore internal to defaults
    hyprctl_keyword "${INTERNAL}, ${INTERNAL_DEFAULT_RES}, ${INTERNAL_DEFAULT_POS}, ${INTERNAL_DEFAULT_SCALE}"

    # (optional) disable external
    # hyprctl_keyword "${EXTERNAL}, off, auto, 1"
  fi
}

stop() {
  echo "$(date) - stopping mirror..."

  # Reset HDMI to extended display if still plugged in
  if hdmi_present; then
    hyprctl_keyword "${EXTERNAL}, ${EXTERNAL_RES}, ${EXTERNAL_POS_NOT_PLUGGED_IN}, ${EXTERNAL_SCALE}"
  fi

  hyprctl_keyword "${INTERNAL}, ${INTERNAL_DEFAULT_RES}, ${INTERNAL_DEFAULT_POS}, ${INTERNAL_DEFAULT_SCALE}"

  # Optional: disable external
  # hyprctl_keyword "${EXTERNAL}, off, auto, 1"
}


################################
# Argument Dispatch
################################

ACTION="${1:-}"

case "$ACTION" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac
