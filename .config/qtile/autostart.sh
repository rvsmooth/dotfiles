#!/bin/bash

## dunst notifications
dunst &

## set wallpaper
feh --bg-fill $HOME/Pictures/Walls/wall.png &

## policy kit
/usr/bin/lxpolkit &
