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

APP='Brightness Control'
CURRENT_BRIGHTNESS=$(ddcutil getvcp 10 | awk -F 'current value =' '{print $2}' | awk -F ',' '{print $1}' | xargs)
BRIGHTNESS_STRING="󰃠  $CURRENT_BRIGHTNESS% (current)"
NOTIFY() {
  notify-send --icon=brightness "$APP" "$@"
}
BRIGHTNESS_OPTS=(
  "$BRIGHTNESS_STRING"
  "10%"
  "20%"
  "30%"
  "40%"
  "50%"
  "60%"
  "70%"
  "80%"
  "90%"
  "100%"
  "Custom"
  "Exit"
)

brighten_it() {
  # Create a menu for Rofi
  CHOICE=$(printf "%s\n" "${BRIGHTNESS_OPTS[@]}" | rofi -dmenu -i -p "Current Brightness: $CURRENT_BRIGHTNESS%" -theme-str 'window { height: 540; }')

  if [[ ! -n "$CHOICE" ]]; then
    exit 0
  else
    case "$CHOICE" in
    "$BRIGHTNESS_STRING")
      NOTIFY "This option only shows current brightness. Use other options to change brightness"
      ;;
    "10%")
      ddcutil setvcp 10 10 && NOTIFY "Brightness has been set to 10%."
      ;;
    "20%")
      ddcutil setvcp 10 20 && NOTIFY "Brightness has been set to 20%."
      ;;
    "30%")
      ddcutil setvcp 10 30 && NOTIFY "Brightness has been set to 30%."
      ;;
    "40%")
      ddcutil setvcp 10 40 && NOTIFY "Brightness has been set to 40%."
      ;;
    "50%")
      ddcutil setvcp 10 50 && NOTIFY "Brightness has been set to 50%."
      ;;
    "60%")
      ddcutil setvcp 10 60 && NOTIFY "Brightness has been set to 60%."
      ;;
    "70%")
      ddcutil setvcp 10 70 && NOTIFY "Brightness has been set to 70%."
      ;;
    "80%")
      ddcutil setvcp 10 80 && NOTIFY "Brightness has been set to 80%."
      ;;
    "90%")
      ddcutil setvcp 10 90 && NOTIFY "Brightness has been set to 90%."
      ;;
    "100%")
      ddcutil setvcp 10 100 && NOTIFY "Brightness has been set to 100%."
      ;;
    "Custom")
      CUSTOM_BRIGHTNESS=$(rofi -dmenu -i -p "Custom brightness (0-100):" -theme-str 'entry { placeholder: "Type desired brightness"; }' -theme-str 'window { height: 400; }')
      if [[ -n "$CUSTOM_BRIGHTNESS" && "$CUSTOM_BRIGHTNESS" =~ ^[0-9]+$ ]] && [ "$CUSTOM_BRIGHTNESS" -ge 0 ] && [ "$CUSTOM_BRIGHTNESS" -le 100 ]; then
        ddcutil setvcp 10 "$CUSTOM_BRIGHTNESS" &&
          NOTIFY "Brightness set to $CUSTOM_BRIGHTNESS%."
      else
        NOTIFY "Invalid custom brightness entered."
      fi
      ;;
    "ON")
      ddcutil setvcp 10 100 &&
        NOTIFY "Brightness set to 100%."
      ;;
    "OFF")
      ddcutil setvcp 10 0 &&
        NOTIFY "Brightness turned off."
      ;;
    "Exit")
      i="2"
      exit 0
      ;;
    *)
      NOTIFY "The operation has been aborted."
      ;;
    esac
  fi
}

i="0"
while [[ $i -lt 1 ]]; do
  brighten_it
done
