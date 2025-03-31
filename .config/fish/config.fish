set -g fish_greeting
set -x TERM xterm-256color
set PATH $PATH ~/.local/bin
set LIBVA_DRIVER_NAME i965

source $HOME/.config/scripts-common/aliases.sh
fish_config theme choose TokyoNight_Night

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
    set -l git_cmd /usr/bin/git
    set -l git_options "--git-dir=$HOME/.dotfiles --work-tree=$HOME"
    eval $git_cmd $git_options config --unset status.showUntrackedFiles
    eval $git_cmd $git_options config status.showUntrackedFiles no

    eval $git_cmd $git_options $argv
end

function convert_file

    mv $argv (echo -e (ls $argv | tr ' ' '_'))

end


#                                 _   
# _ __  _ __ ___  _ __ ___  _ __ | |_ 
#| '_ \| '__/ _ \| '_ ` _ \| '_ \| __|
#| |_) | | | (_) | | | | | | |_) | |_ 
#| .__/|_|  \___/|_| |_| |_| .__/ \__|
#|_|                       |_|        

starship init fish | source
