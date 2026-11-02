#!/usr/bin/env bash
set -euo pipefail

################################
# Configuration
################################

INTERNAL="eDP-2"
EXTERNAL="HDMI-A-1"

# Laptop display while mirroring
INTERNAL_HDMI_RES="1920x1080@60"
INTERNAL_HDMI_POS="0x0"
INTERNAL_HDMI_SCALE="1.60"

# Normal laptop settings
INTERNAL_DEFAULT_RES="preferred"
INTERNAL_DEFAULT_POS="0x0"
INTERNAL_DEFAULT_SCALE="1.60"

# HDMI settings
EXTERNAL_RES="preferred"
EXTERNAL_POS_MIRROR="0x0"
EXTERNAL_POS_EXTENDED="1600x0"
EXTERNAL_SCALE="1.60"

################################
# Helpers
################################

log() {
    printf '%s - %s\n' "$(date '+%F %T')" "$*"
}

monitor_present() {
    hyprctl -j monitors all |
        jq -e --arg name "$1" 'any(.[]; .name == $name)' >/dev/null
}

set_monitor() {
    local output="$1"
    local mode="$2"
    local position="$3"
    local scale="$4"
    local mirror="${5:-}"

    # Values come from the trusted configuration constants above.
    hyprctl eval "
        hl.monitor({
            output = \"$output\",
            mode = \"$mode\",
            position = \"$position\",
            scale = $scale,
            mirror = \"$mirror\",
            disabled = false,
        })
    "
}

restore_internal() {
    set_monitor \
        "$INTERNAL" \
        "$INTERNAL_DEFAULT_RES" \
        "$INTERNAL_DEFAULT_POS" \
        "$INTERNAL_DEFAULT_SCALE"
}

################################
# Actions
################################

start() {
    if monitor_present "$EXTERNAL"; then
        log "Starting mirror: $EXTERNAL mirrors $INTERNAL"

        # Configure the source before enabling its mirror.
        set_monitor \
            "$INTERNAL" \
            "$INTERNAL_HDMI_RES" \
            "$INTERNAL_HDMI_POS" \
            "$INTERNAL_HDMI_SCALE"

        set_monitor \
            "$EXTERNAL" \
            "$EXTERNAL_RES" \
            "$EXTERNAL_POS_MIRROR" \
            "$EXTERNAL_SCALE" \
            "$INTERNAL"
    else
        log "$EXTERNAL not connected; restoring laptop settings"
        restore_internal
    fi
}

stop() {
    log "Stopping mirror"

    if monitor_present "$EXTERNAL"; then
        # An empty mirror value explicitly clears mirroring.
        set_monitor \
            "$EXTERNAL" \
            "$EXTERNAL_RES" \
            "$EXTERNAL_POS_EXTENDED" \
            "$EXTERNAL_SCALE" \
            ""
    fi

    restore_internal
}

################################
# Argument dispatch
################################

case "${1:-}" in
    start|stop)
        command -v jq >/dev/null || {
            printf 'Missing dependency: jq\n' >&2
            exit 1
        }

        "$1"
        ;;
    *)
        printf 'Usage: %s {start|stop}\n' "$0" >&2
        exit 1
        ;;
esac
