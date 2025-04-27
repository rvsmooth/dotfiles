#!/bin/bash

SWAY_PKGS="
grim
qt6-wayland
rofi-wayland
slurp
swaybg
swayidle
swaylock
swaynag
waybar
wl-clipboard 
sway
xdg-desktop-portal-gtk
xdg-desktop-portal-wlr
"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

PRED() {
  echo -e "${RED}=> $@${RESET}"
}

PGREEN() {
  echo -e "${GREEN}=> $@${RESET}"
}

PYELL() {
  echo -e "${YELLOW}=> $@${RESET}"
}

PBLUE() {
  echo -e "${BLUE}=> $@${RESET}"
}

PDONE() {
  sleep 1 && PGREEN Done... && echo && sleep 1
}
__zypper_install() {
  PYELL Installing "$@"
  sudo zypper --non-interactive --no-gpg-checks \
    install --auto-agree-with-licenses \
    --no-recommends "$@"
}

for package in $SWAY_PKGS; do
  echo $package
  __zypper_install $package
done
