#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#                            _       
#                           | |      
#  _____  ___ __   ___  _ __| |_ ___ 
# / _ \ \/ | '_ \ / _ \| '__| __/ __|
#|  __/>  <| |_) | (_) | |  | |_\__ \
# \___/_/\_| .__/ \___/|_|   \__|___/
#          | |                       
#          |_|                      

if [ -f "$HOME/.local/bin/lvim" ] ; then
export EDITOR='lvim'
export VISUAL='lvim'
else
export EDITOR='nvim'
export VISUAL='nvim'
fi

#  __                  _   _                 
# / _|                | | (_)                
#| |_ _   _ _ __   ___| |_ _  ___  _ __  ___ 
#|  _| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
#| | | |_| | | | | (__| |_| | (_) | | | \__ \
#|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

function sssh() {
eval "$(ssh-agent -s)"
ssh-add $1
}

function config() {
    git_cmd="/usr/bin/git"
    git_options="--git-dir=$HOME/.dotfiles --work-tree=$HOME"
    
    untracked_files=$($git_cmd $git_options config --get status.showUntrackedFiles 2>/dev/null)
    
    if [[ -z "$untracked_files" || "$untracked_files" == "all" ]]; then
        $git_cmd $git_options config --unset status.showUntrackedFiles
        $git_cmd $git_options config status.showUntrackedFiles no
        echo "UntrackedFiles was set to 'all' or not set. Changed to 'no'."
    else
        echo "UntrackedFiles is already set to no."
    fi
    
    $git_cmd $git_options "$@"
}

function convert_file(){

mv "$1" $(echo -e $(ls "$1" | tr ' ' '_'))

}

#             _   _         
#            | | | |        
# _ __   __ _| |_| |__  ___ 
#| '_ \ / _` | __| '_ \/ __|
#| |_) | (_| | |_| | | \__ \
#| .__/ \__,_|\__|_| |_|___/
#| |                        
#|_|                        

export PATH="$HOME/.local/bin:$PATH"

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
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Re-login to apply."
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Re-login to apply."

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

eval "$(starship init bash)"
