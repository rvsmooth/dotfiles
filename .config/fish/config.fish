set -g fish_greeting
set -x TERM xterm-256color
set PATH $PATH ~/.local/bin

function ssh_git
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


