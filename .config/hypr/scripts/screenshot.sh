#!/bin/bash
#______ _   _ _____                       _   _     
#| ___ \ | | /  ___|                     | | | |    
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__  
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \ 
#| |\ \\ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
# 
# desc: A Simple Screenshot Script utilising grim & slurp                                                  
# Copyright (c) 2024 RVSmooth
# https://gitlab.com/RVSmooth 
                 
                                                                      
SCREENSHOT_DIR="$(xdg-user-dir PICTURES)"/Screenshots
SCREENSHOT="$SCREENSHOT_DIR"/"$(date +'screenshot_%d-%m-%Y-%H:%M:%S.png')"

if [ -d "$SCREENSHOT_DIR" ]; then
	echo "SCREENSHOT_DIR exists"
else
	mkdir -p "$SCREENSHOT_DIR"
fi

case "$1" in
  --full | -f)
    grim "$SCREENSHOT" && 
	    notify-send  "Screenshot Captured" "Saved to $SCREENSHOT"
    ;;
  --select | -s)
    grim -c -g "$(slurp)" "$SCREENSHOT" && 
	    notify-send  "Screenshot Captured" "Saved to "$SCREENSHOT""
    ;;
  --sleep5shot | -s5s)
    notify-send  "Screenshot Capture" "Waiting for 5 seconds to Capture a Screenshot"
    sleep 5 && grim "$SCREENSHOT" && 
	    notify-send  "Screenshot Captured" " Saved to $SCREENSHOT"
    ;;
  *)
    usage
    ;;
esac
