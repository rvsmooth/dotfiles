#!/usr/bin/env bash
#______ _   _ _____                       _   _
#| ___ \ | | /  ___|                     | | | |
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \
#| |\ \ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
#
# Copyright (c) 2024 rvsmooth
# https://github.com/rvsmooth

rofi -disable-history -show drun -font "Roboto 11" -drun-display-format {name} -show-icons -p "Apps:" \
  -theme-str '* {background-color: @background;}' \
  -theme-str 'window {width: 1700; height: 1000;}' \
  -theme-str 'listview {margin: 40px 0px -40 0px; spacing: 20px; columns: 10; layout: vertical; dynamic: true;}' \
  -theme-str 'element {padding: 10px; spacing: 20px; orientation: vertical; border-radius: 16px;}' \
  -theme-str 'element-text, element-icon { size: 2.5em; background-color: inherit; horizontal-align: 0.5; }' \
  -theme-str 'element selected.normal { background-color: @accent; text-color: @black; }' \
  -theme-str 'element normal.normal { background-color: @background; }' \
  -theme-str 'prompt {enabled: false;}' \
  -theme-str 'mainbox {padding: 2% 0% 2% 1%;}' \
  -theme-str 'entry {horizontal-align: 0.5; placeholder-color: @black; text-color: @black; background-color: @accent; padding: 7px 0px 7px 0px; border-radius: 50%;}'
