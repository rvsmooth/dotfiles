#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"

function run {
  if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null; then
    $@ &
  fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#run hyprpaper
run swww-daemon
swww img $HOME/.cache/wallpaper/default
run dunst
waybar -c "${WAYBAR_DIR}/niri/config.jsonc" -s "${WAYBAR_DIR}/niri/style.css" &
wl-paste --watch cliphist store &
syncthing serve --no-browser &
