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

# tab autocompletions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' list-colors '=(#b)blue'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# history
export HISTSIZE=100000
export SAVEHIST=20000
export HISTFILE="$HOME/.cache/zsh_history"
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
source ~/.config/zsh/plugins/history-substring-search.zsh
source ~/.config/scripts-common/aliases.sh
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
export LIBVA_DRIVER_NAME=i965


flatpak_theme() {
	for package in $(ls "$HOME/.var/app/"); do
		[ -d "$HOME/.var/app/$package/config/gtk-3.0" ] ||
		/usr/bin/ln -s "$HOME/.config/gtk-3.0" "$HOME/.var/app/$package/config/"
	done
}

#                                 _   
# _ __  _ __ ___  _ __ ___  _ __ | |_ 
#| '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#| |_) | | | (_) | | | | | | |_) | |_ 
#| .__/|_|  \___/|_| |_| |_| .__/ \__|
#|_|                       |_|        

eval "$(starship init zsh)"
source ~/.config/zsh/plugins/zsh-syntax-highlighting.zsh
source ~/.config/zsh/plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh
