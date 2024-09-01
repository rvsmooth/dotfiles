#!/bin/bash
#______ _   _ _____                       _   _     
#| ___ \ | | /  ___|                     | | | |    
#| |_/ / | | \ `--. _ __ ___   ___   ___ | |_| |__  
#|    /| | | |`--. \ '_ ` _ \ / _ \ / _ \| __| '_ \ 
#| |\ \\ \_/ /\__/ / | | | | | (_) | (_) | |_| | | |
#\_| \_|\___/\____/|_| |_| |_|\___/ \___/ \__|_| |_|
#                                                   
# desc: Simple Volume Management Script
# Copyright (c) 2024 RVSmooth
# https://gitlab.com/RVSmooth 


if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

NOTIFY_VOL="dunstify -a 'VolumeChange' -i audio-volume-high-symbolic -t 2000 -h int:value:"$(pamixer --get-volume / 2)" "$(pamixer --get-mute | grep -q 'true' && echo 'Muted' || echo "Volume: $(pamixer --get-volume)%")" -h string:synchronous:volume"

for arg in "$@"; do
    case $arg in
        --pw-incvol)
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+; 
            $NOTIFY_VOL
            ;;
        --pw-decvol)
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-;
            $NOTIFY_VOL
            ;;
        --pw-mute)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;
            $NOTIFY_VOL
            ;;
        --pa-mute)
            pamixer -t;
            $NOTIFY_VOL
            ;;
        --pa-incvol)
            pamixer -i 5;
            $NOTIFY_VOL
            ;;
        --pa-decvol)
            pamixer -d 5;
            $NOTIFY_VOL
            ;;
        *)
            echo "Unknown option: $arg"
            show_help
            exit 1
            ;;
    esac
done
