set -g fish_greeting
set -x TERM xterm-256color
set PATH $PATH ~/.local/bin

#  __                  _   _                 
# / _|                | | (_)                
#| |_ _   _ _ __   ___| |_ _  ___  _ __  ___ 
#|  _| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#| | | |_| | | | | (__| |_| | (_) | | | \__ \
#|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

function sssh
	eval (ssh-agent -c)
	ssh-add $argv
end

function config
    set -l git_cmd "/usr/bin/git"
    set -l git_options "--git-dir=$HOME/.dotfiles --work-tree=$HOME"
    
    set -l untracked_files (eval $git_cmd $git_options config --get status.showUntrackedFiles)
    
    if test -z "$untracked_files" -o "$untracked_files" = "all"
        eval $git_cmd $git_options config --unset status.showUntrackedFiles
        eval $git_cmd $git_options config status.showUntrackedFiles no
        echo "UntrackedFiles was set to 'all' or not set. Changed to 'no'."
    else
        echo "UntrackedFiles is already set to no."
    end
    
    eval $git_cmd $git_options $argv
end

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
alias yupdate='yay -Syyu --noconrim'

#switch between shells
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Re-login to apply.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Re-login to apply.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Re-login to apply.'"

#mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"

#Recently Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"


#                                 _   
# _ __  _ __ ___  _ __ ___  _ __ | |_ 
#| '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#| |_) | | | (_) | | | | | | |_) | |_ 
#| .__/|_|  \___/|_| |_| |_| .__/ \__|
#|_|                       |_|        

starship init fish | source
