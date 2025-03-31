#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#source aliases
source ~/.config/scripts-common/aliases.sh

#                            _
#                           | |
#  _____  ___ __   ___  _ __| |_ ___
# / _ \ \/ | '_ \ / _ \| '__| __/ __|
#|  __/>  <| |_) | (_) | |  | |_\__ \
# \___/_/\_| .__/ \___/|_|   \__|___/
#          | |
#          |_|

if [ -f "$HOME/.local/bin/lvim" ]; then
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

function convert_file() {

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

#                                 _
# _ __  _ __ ___  _ __ ___  _ __ | |_
#| '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#| |_) | | | (_) | | | | | | |_) | |_
#| .__/|_|  \___/|_| |_| |_| .__/ \__|
#|_|                       |_|

eval "$(starship init bash)"
