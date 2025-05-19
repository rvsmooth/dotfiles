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

APP='ClipBoard'

NOTIFY() {

  notify-send --icon=clipboard "$APP" "$@"

}

COPY_LABEL="List [Copy]"
DELETE_LABEL="List [Delete]"
CLEAR_LABEL="Clear Database"

CLIP_OPTIONS=(
  "$COPY_LABEL"
  "$DELETE_LABEL"
  "$CLEAR_LABEL"
)

# Create a menu for Rofi
CHOICE=$(printf "%s\n" "${CLIP_OPTIONS[@]}" | rofi -dmenu -i -p "$APP")

case "$CHOICE" in
"$COPY_LABEL")
  SELECTED_ITEM=$(cliphist list | rofi -dmenu -i -p "$COPY_LABEL")
  if [[ -n "$SELECTED_ITEM" ]]; then
    FINAL_TEXT=$(echo "$SELECTED_ITEM" | cliphist decode)
    echo -e "$FINAL_TEXT" | wl-copy
    NOTIFY "'$FINAL_TEXT' has been copied to the clipboard"
  else
    NOTIFY "No text selected to copy."
  fi
  ;;
"$DELETE_LABEL")
  SELECTED_ITEM=$(cliphist list | rofi -dmenu -i -p "$COPY_LABEL")
  if [[ -n "$SELECTED_ITEM" ]]; then
    FINAL_TEXT=$(echo "$SELECTED_ITEM" | cliphist decode)
    echo -n "$SELECTED_ITEM" | cliphist delete
    NOTIFY "'$FINAL_TEXT' has been deleted from clipboard"
  else
    NOTIFY "No text selected to delete."
  fi
  ;;
"$CLEAR_LABEL")
  cliphist wipe &&
    NOTIFY "Database cleared."
  ;;
*)
  NOTIFY "Operation aborted."
  ;;
esac
