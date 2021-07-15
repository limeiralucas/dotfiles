#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

function src_shell() {
    echo
    read -p "Do you want to reload $SHELL? (y/N) "
    if [[ $REPLY =~ [Yy]$ ]]; then
        exec $SHELL
    fi
}

function _setup() {
    local EXP="[ $1 $2 ]"
    if eval $EXP; then 
        echo
        read -p "$2 exists. Want to override? (y/N) "
        if [[ ! $REPLY =~ [Yy]$ ]]; then
            echo "$2 skipped"
            return 1
        fi
        echo "Overriding $2"
        mv $2 "$2.backup"
    fi
    echo "$2 setup!"
}

function setup() {
    if _setup $1 $2; then
        ln -s $3 $2
    fi
}
function setup_git() {
    if _setup "-d" $1; then
        git clone $2 $1
    fi
}


setup -f $HOME/.tmux.conf $SCRIPTPATH/tmux/tmuxconf
setup -f $HOME/.zshrc $SCRIPTPATH/zsh/zshrc
setup_git $HOME/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm

src_shell
