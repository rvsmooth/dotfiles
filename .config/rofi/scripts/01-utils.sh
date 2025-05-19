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

APP='Reloader'

NOTIFY() {

  notify-send --icon=view-refresh-symbolic "$APP" "$@"

}
set -x
function __reload_app() {
  APP_PID=$(pgrep "$1")
  APP_PATH=$(which "$1")
  APP_NAME="$1"
  if [ -n "$APP_PID" ]; then
    kill -9 "$APP_PID"
    NOTIFY Restarting "$APP_NAME"
    "$APP_PATH"
  else
    "$APP_PATH"
  fi
}
function __kill_app() {
  APP_PID=$(pgrep "$1")
  if [ -n "$APP_PID" ]; then
    kill -9 "$APP_PID"
  else
    echo "App is not running"
  fi
}
