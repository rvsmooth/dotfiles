#!/bin/bash
#______ _   _ _____                       _   _
#| ___ \ | | /  ___|                     | | | |
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \
#| |\ \ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
#
# Copyright (c) 2024 rvsmooth
# https://github.com/rvsmooth

APP='ColorShift'

NOTIFY() {

  notify-send --icon=redshift "$APP" "$@"

}

TEMP_OPTIONS=(
  "ON"
  "OFF"
  "Custom"
)

# Create a menu for Rofi
CHOICE=$(printf "%s\n" "${TEMP_OPTIONS[@]}" | rofi -dmenu -i -p "$APP")

case "$CHOICE" in
"Custom")
  CUSTOM_TEMP=$(rofi -dmenu -i -p "Custom temperature (e.g., 3000K, only for xorg):")
  if [[ -n "$CUSTOM_TEMP" ]]; then
    redshift -O "$CUSTOM_TEMP" &&
      NOTIFY "Temperature has been set to "$CUSTOM_TEMP"."
  else
    NOTIFY "No custom temperature entered."
  fi
  ;;
"ON")
  if [[ $XDG_SESSION_DESKTOP == "Hyprland" ]]; then
    hyprctl keyword decoration:screen_shader ~/.config/hypr/scripts/nightlight_shader.frag &&
      NOTIFY "Bluelight filter has been turned on."
  else
    redshift -O 4500K &&
      NOTIFY "Bluelight filter has been turned on."
  fi
  ;;
"OFF")
  if [[ $XDG_SESSION_DESKTOP == "Hyprland" ]]; then
    hyprctl reload &&
      NOTIFY "Bluelight filter has been turned off."
  else
    redshift -x &&
      NOTIFY "Bluelight filter has been turned off."
  fi
  ;;
*)
  NOTIFY "The operation has been aborted."
  ;;
esac
