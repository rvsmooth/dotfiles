#       _ _                    
#      | (_)                   
#  __ _| |_  __ _ ___  ___ ___ 
# / _` | | |/ _` / __|/ _ / __|
#| (_| | | | (_| \__ |  __\__ \
# \__,_|_|_|\__,_|___/\___|___/                           

# list & grep
alias ll='ls -alFh'
alias ls='ls --color=auto'
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
alias pupdate='paru -Syyu --noconfirm'
alias yupdate='yay -Syyu --noconfirm'

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
