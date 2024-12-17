#!/usr/bin/env bash

# check for paru
# if does not exist check for yay
# if does not exist use pacman
#


function update_paru(){
	paru -Syyu
}

function update_yay(){
	yay -Syyu
}

function update_pacman(){
	sudo pacman -Syyu
}

function update_flatpak(){
	flatpak update -y
}
if command -v paru &> /dev/null; then
	export PARU=true
	export MANAGER=paru
	echo "Paru is installed. Updating the system..."
elif command -v yay &> /dev/null; then
	export YAY=true
	export MANAGER=yay
	echo "Paru is not installed. Updating the system via Yay..."
else 
	echo "Paru or Yay is not installed. Updating the system via pacman..."
	export PACMAN=true
	export MANAGER=pacman	
fi


if command -v flatpak &> /dev/null; then
	export FLATPAK=true
	echo "flatpak is installed. Flatpaks will be updated as well..."
else
	echo "Flapaks is not installed. Skipping flatpak updates..."
fi


if [[ "$PARU" == "true" ]]; then
	update_paru
	update_flatpak
elif [[ "$YAY" == "true" ]]; then
	update_yay
	update_flatpak
else 
	update_pacman
	update_flatpak
fi
