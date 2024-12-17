#       _ _                    
#      | (_)                   
#  __ _| |_  __ _ ___  ___ ___ 
# / _` | | |/ _` / __|/ _ / __|
#| (_| | | | (_| \__ |  __\__ \
# \__,_|_|_|\__,_|___/\___|___/                           

# list & grep
alias ll='ls -alFh --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'


#pacman
alias sps='sudo pacman -S'
alias spr='sudo pacman -R'
alias sprss='sudo pacman -Rss'
alias sprdd='sudo pacman -Rdd'
alias spqo='sudo pacman -Qo'
alias spsii='sudo pacman -Sii'
alias spqi='pacman -Qi'
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias update="bash ~/.config/scripts-common/updater.sh"

#switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Re-login to apply.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Re-login to apply.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Re-login to apply.'"

#mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

#Recently Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#rtl8xxxu restart
alias rsrtl="sudo rmmod rtl8xxxu;sudo modprobe rtl8xxxu"

#yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

