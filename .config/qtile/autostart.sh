#!/bin/bash
picom --daemon &
dunst &
feh --bg-fill $HOME/Pictures/wallpapers/default &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/emacs --daemon &
# variety &
