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

#!/bin/bash

show_help() {
    echo "Usage: $0 [options]"
    echo "--pw-incvol   Increase volume (PipeWire)"
    echo "--pw-decvol   Decrease volume (PipeWire)"
    echo "--pw-mute     Toggle mute (PipeWire)"
    echo "--pa-mute     Toggle mute (PulseAudio)"
    echo "--pa-incvol   Increase volume (PulseAudio)"
    echo "--pa-decvol   Decrease volume (PulseAudio)"
}

notify_volume() {
    local volume
    local mute
    if [[ "$USE_PIPEWIRE" == "true" ]]; then
        volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
        mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
    else
        volume=$(pamixer --get-volume)
        mute=$(pamixer --get-mute)
    fi

    echo "Volume: $volume"
    echo "Mute: $mute"      

    local volume_text
    if [[ "$mute" == "[MUTED]" ]]; then
        volume_text="Muted"
        volume=0  
    else
        volume_text="Volume: ${volume}%"
    fi

    echo "Notification text: $volume_text" 

    dunstify -a 'VolumeChange' -i audio-volume-high-symbolic -t 2000 \
        -h int:value:"$volume" "$volume_text" \
        -h string:synchronous:volume
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi


for arg in "$@"; do
    case $arg in
        --pw-incvol)
            USE_PIPEWIRE=true
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+;
            notify_volume
            ;;
        --pw-decvol)
            USE_PIPEWIRE=true
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-;
            notify_volume
            ;;
        --pw-mute)
            USE_PIPEWIRE=true
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;
            notify_volume
            ;;
        --pa-mute)
            pamixer -t;
            notify_volume
            ;;
        --pa-incvol)
            pamixer -i 5;
            notify_volume
            ;;
        --pa-decvol)
            pamixer -d 5;
            notify_volume
            ;;
        *)
            echo "Unknown option: $arg"
            show_help
            exit 1
            ;;
    esac
done





