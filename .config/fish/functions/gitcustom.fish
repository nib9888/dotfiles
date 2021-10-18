function gitcustom -d "Git, but using the bare repo in ~"
    /usr/bin/git --git-dir=$HOME/.git-dotfiles/ --work-tree=$HOME $argv
end
