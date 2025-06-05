#!/bin/bash
export DESKTOP_SESSION=qtile
picom --daemon &
dunst &
feh --bg-fill $HOME/.cache/wallpaper/default &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/emacs --daemon &
# variety &
