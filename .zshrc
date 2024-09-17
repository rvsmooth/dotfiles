#           _              
#   _______| |__  _ __ ___ 
#  |_  / __| '_ \| '__/ __|
# _ / /\__ \ | | | | | (__ 
#(_)___|___/_| |_|_|  \___|


#                  __ _       
#  ___ ___  _ __  / _(_) __ _ 
# / __/ _ \| '_ \| |_| |/ _` |
#| (_| (_) | | | |  _| | (_| |
# \___\___/|_| |_|_| |_|\__, |
#                       |___/ 

# history
export HISTSIZE=100000
export SAVEHIST=20000
export HISTFILE="$HOME/.cache/zsh/history"
setopt hist_ignore_dups     # do not record an event that was just recorded again
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_space    # do not record an event starting with a space
setopt hist_save_no_dups    # do not write a duplicate event to the history file
setopt inc_append_history   # write to the history file immediately, not when the shell exits
setopt share_history        # share history between terminals

#       _             _           
# _ __ | |_   _  __ _(_)_ __  ___ 
#| '_ \| | | | |/ _` | | '_ \/ __|
#| |_) | | |_| | (_| | | | | \__ \
#| .__/|_|\__,_|\__, |_|_| |_|___/
#|_|            |___/             
#

source ~/.config/zsh/plugins/auto-notify.plugin.zsh
source ~/.config/zsh/plugins/you-should-use.plugin.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-history-substring-search.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting.plugin.zsh

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
    git_cmd='/usr/bin/git'
    git_dir="$HOME/.dotfiles/"
    work_tree="$HOME"

    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" config --unset status.showuntrackedfiles 2>/dev/null
    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" config status.showuntrackedfiles no

    $git_cmd --git-dir="$git_dir" --work-tree="$work_tree" "$@" 
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

eval "$(starship init zsh)"
