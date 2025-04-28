#!/bin/bash 

# kill all waybar processes
pkill -9 waybar

# wait for 1 second
sleep 0.5

# Restart waybar 
waybar -c ~/.config/waybar/hypr/config.jsonc -s ~/.config/waybar/hypr/style.css

# reload hyprland
hyprctl reload


