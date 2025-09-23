#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null; then
    $@ &
  fi
}

waybar -c "${WAYBAR_DIR}/niri/config.jsonc" -s "${WAYBAR_DIR}/niri/style.css" &
