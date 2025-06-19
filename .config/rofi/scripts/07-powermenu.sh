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
# Define the options

APP='PowerMenu'

NOTIFY() {

  notify-send --icon=system-shutdown "$APP" "$@"

}
options="Shutdown\nReboot\nLogout\nSuspend"
run_rofi() {

  rofi -dmenu \
    -theme-str 'inputbar {enabled: false;}' \
    -theme-str 'prompt {enabled: false;}' \
    -theme-str 'window {height: 195; width: 750;}' \
    -theme-str 'listview {margin: 14px; spacing: 10px; lines: 4; columns: 4; fixed-columns: true; padding: 10px; layout: horizontal;}' \
    -theme-str 'element {padding: 50px;}' \
    -theme-str 'inputbar {enabled: false;}' \
    -theme-str 'prompt {enabled: false;}' \
    -theme-str ' window {height: 195;}'

}
# Use rofi to display the menu
selected=$(echo -e "$options" | run_rofi)

# Act based on the selected option
case "$selected" in
Shutdown)
  systemctl poweroff
  ;;
Reboot)
  systemctl reboot
  ;;
Logout)
  if [[ $XDG_SESSION_DESKTOP == "Hyprland" ]]; then
    hyprctl dispatch exit
  elif [[ $XDG_SESSION_DESKTOP == "sway" ]]; then
    swaymsg exit
  elif [[ $XDG_SESSION_DESKTOP == "qtile" ]]; then
    qtile cmd-obj -o cmd -f shutdown
  else
    NOTIFY "Unable to determine WM. Check PowerMenu script"
  fi
  ;;
Suspend)
  systemctl suspend
  ;;
*)
  echo "Invalid option"
  ;;
esac
