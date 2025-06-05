#!/bin/bash
#______ _   _ _____                       _   _
#| ___ \ | | /  ___|                     | | | |
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \
#| |\ \ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
#
# Copyright (c) 2025 rvsmooth
# https://github.com/rvsmooth
set -x
source ~/.config/rofi/scripts/01-utils.sh
APP='Wallpaper'
WALL_SRC="${HOME}/Pictures/wallpapers"
WALL_TGT="${HOME}/.cache/wallpaper/default"
WALL_THM="${WALL_SRC}/themed"
WALL_EXTRA="${WALL_SRC}/extras"

[ ! -d "${HOME}/.cache/wallpaper" ] && mkdir -p"${HOME}/.cache/wallpaper"

NOTIFY() {
  notify-send --icon=image-x-generic "$APP" "$@"
}

OPTIONS=(
  "Custom directory"
  "Themed Wallpapers"
  "Extra Wallpapers"
)

theme_hypr() {
  __reload_app hyprpaper
}

theme_sway() {
  __kill_app swaybg
  swaymsg output * bg "$WALL_SRC/default" fill &
}

theme_qtile() {
  feh --bg-fill "$WALL_SRC/default" &
}

apply_wall() {

  if [[ "$XDG_SESSION_DESKTOP" == "qtile" ]]; then
    theme_qtile
  elif [[ -n "$(pgrep qtile)" ]]; then
    theme_qtile
  elif [[ "$XDG_SESSION_DESKTOP" == "sway" ]]; then
    theme_sway
  elif [[ -n "$(pgrep sway)" ]]; then
    theme_sway
  elif [[ "$XDG_SESSION_DESKTOP" == "hyprland" ]]; then
    theme_hypr
  elif [[ -n "$(pgrep Hyprland)" ]]; then
    theme_hypr
  else
    echo "Neither sway nor hyprland is installed."
  fi

}
# Create a menu for Rofi
CHOICE=$(printf "%s\n" "${OPTIONS[@]}" | rofi -dmenu -i -p "$APP")

case "$CHOICE" in
"Custom directory")
  CUSTOM_WALL=$(rofi -filebrowser-command echo -show filebrowser -theme fullscreen-preview)
  WALL=${CUSTOM_WALL}
  if [[ -n "$WALL" ]]; then
    cp -f "$WALL" "$WALL_TGT"
    apply_wall
  fi
  ;;
"Themed Wallpapers")
  cd $WALL_THM
  FILES=$(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.svg" \) | awk -F '/' '{print $NF}')
  THEMED_WALL=$(for a in $FILES; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -theme fullscreen-preview)
  WALL=${THEMED_WALL}
  if [[ -n "$WALL" ]]; then
    cp -f "$WALL_THM/$WALL" "$WALL_TGT"
    apply_wall
  fi
  ;;
"Extra Wallpapers")
  cd $WALL_EXTRA
  FILES=$(find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o -iname "*.svg" \) | awk -F '/' '{print $NF}')
  EXTRA_WALL=$(for a in $FILES; do echo -en "$a\0icon\x1f$a\n"; done | rofi -dmenu -theme fullscreen-preview)
  WALL=${EXTRA_WALL}
  if [[ -n "$WALL" ]]; then
    cp -f "$WALL_EXTRA/$WALL" "$WALL_TGT"
    apply_wall
  fi
  ;;
*)
  NOTIFY "The operation has been aborted."
  ;;
esac
