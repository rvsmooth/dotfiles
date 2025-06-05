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
#
set -x
source ~/.config/rofi/scripts/01-utils.sh

ROFI_THEMES_PATH="${HOME}/.config/rofi/themes/colors"
QTILE_COLORS_PATH="${HOME}/.config/qtile/colors.py"
QTILE_THEME_CURRENT="$(cat $QTILE_COLORS_PATH | awk -F '=' '/default/ {print $2}' | xargs)"
KITTY_CONFIG_PATH="${HOME}/.config/kitty"
WAYBAR_THEME_PATH="${HOME}/.config/waybar/themes"
DUNST_THEME_PATH="${HOME}/.config/dunst/themes"
WALL_SRC="${HOME}/Pictures/wallpapers/themed"
WALL_TGT="${HOME}/.cache/wallpaper"
HYPR_THEMES_PATH="${HOME}/.config/hypr/themes"
SWAY_THEMES_PATH="${HOME}/.config/sway/themes"

[ ! -d "${HOME}/.cache/wallpaper" ] && mkdir -p"${HOME}/.cache/wallpaper"

declare -A themes

themes["Catppuccin"]="Catppuccin.png"
themes["Dracula"]="Dracula.jpg"
themes["EverforestDarkHard"]="EverforestDarkHard.jpg"
themes["GruvBox"]="GruvBox.jpg"
themes["Nord"]="Nord.png"
themes["SpringBlossom"]="SpringBlossom.jpg"
themes["Tokyonight"]="Tokyonight.png"
themes["Graphite"]="Graphite.png"

function theme_hypr() {
  __kill_app waybar
  waybar -c "${HOME}/.config/waybar/hypr/config.jsonc" -s "${HOME}/.config/waybar/hypr/style.css" &
  __reload_app hyprpaper &&
    hyprctl reload
}

function theme_sway() {
  __kill_app swaybg
  swaymsg output * bg "$WALL_SRC/default" fill &
  __kill_app waybar
  waybar -c "${HOME}/.config/waybar/sway/config.jsonc" -s "${HOME}/.config/waybar/sway/style.css" &
  swaymsg reload &
}

function theme_qtile() {
  qtile cmd-obj -o cmd -f restart
  feh --bg-fill "$WALL_SRC/default" &
}

function apply_theme() {

  FIND="default = $QTILE_THEME_CURRENT"
  REPLACE="default = $THEME_CHOICE"

  #rofi
  cp -f "$ROFI_THEMES_PATH/$THEME_CHOICE.rasi" "$ROFI_THEMES_PATH/default.rasi"

  #qtile
  sed -i "s/$FIND/$REPLACE/g" "$QTILE_COLORS_PATH"

  #hypr and sway
  cp -f "$WAYBAR_THEME_PATH/$THEME_CHOICE.css" "$WAYBAR_THEME_PATH/default.css"
  cp -r "$HYPR_THEMES_PATH/$THEME_CHOICE.conf" "$HYPR_THEMES_PATH/default.conf"
  cp -r "$SWAY_THEMES_PATH/$THEME_CHOICE.conf" "$SWAY_THEMES_PATH/default.conf"

  #kitty
  cp -f "$KITTY_CONFIG_PATH/$THEME_CHOICE.conf" "$KITTY_CONFIG_PATH/default.conf"

  #dunst
  cp -f "$DUNST_THEME_PATH/$THEME_CHOICE" "$DUNST_THEME_PATH/../dunstrc"
  pkill -9 dunst

  # wallpaper
  rm "$WALL_TGT/default"
  cp -f -v "$WALL_SRC/${themes[$THEME_CHOICE]}" "$WALL_TGT/default"

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

THEME_CHOICE=$(printf '%s\n' "${!themes[@]}" | rofi -dmenu -i -p "Select a theme:")

if [[ -n "$THEME_CHOICE" ]]; then
  echo "You selected: $THEME_CHOICE"
  echo "Applying theme..."
  apply_theme
  echo "Done"
else
  echo "No valid selection made."
fi
