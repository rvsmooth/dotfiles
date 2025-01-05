#!/bin/bash

# Function to display usage
browser1="flatpak run org.mozilla.firefox"
browser2="flatpak run com.brave.Browser"
email="flatpak run eu.betterbird.Betterbird"

usage() {
  echo 'Usage: $0 [-b1|--browser1] for "$browser1"  or [-b2|--browser2] for "$browser2" or [-e|--email] for "$email"'
  exit 1
}

# Check if arguments are provided
if [ $# -eq 0 ]; then
  usage
fi

# Parse the command-line arguments
case "$1" in
  -b1|--browser1)
    $browser1 & 
    ;;
  -b2|--browser2)
    $browser2 &  
    ;;
  -e|--email)
    $email &  
    ;;
  *)
    usage
    ;;
esac

