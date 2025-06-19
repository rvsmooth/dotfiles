#!/bin/bash
#______ _   _ _____                       _   _
#| ___ \ | | /  ___|                     | | | |
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \
#| |\ \\ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
#
# Copyright (c) 2024 rvsmooth
# https://github.com/rvsmooth

ROFI_DIR="$HOME/.config/rofi"
ROFI_SCRIPTS_DIR="$ROFI_DIR/scripts"

declare -A utils
utils["Appdrawer"]="02-appdrawer.sh"
utils["Bluetooth"]="03-bluetooth.sh"
utils["Brightness"]="04-brightness.sh"
utils["Clipboard"]="05-clipboard.sh"
utils["Emojis"]="06-emojis.sh"
utils["Powermenu"]="07-powermenu.sh"
utils["Themer"]="08-themer.sh"
utils["Wifimenu"]="09-wifimenu.sh"
utils["Colorshift"]="10-colorshift.sh"
utils["Wallpaper"]="11-wallpaper.sh"

ROFI_UTILS_CMD=$(printf '%s\n' "${!utils[@]}" | rofi -dmenu -i -p "Utilities")

if [ -n "$ROFI_UTILS_CMD" ]; then
  bash "$ROFI_SCRIPTS_DIR/${utils[$ROFI_UTILS_CMD]}"
else
  exit 1
fi
