#!/bin/sh

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

function color() {
    echo -e "$1$2${NC}"
}

function src_shell() {
    echo
    read -p "$(color $BOLD "Do you want to reload $SHELL (y/N)? ")" REPLY
    if [[ $REPLY =~ [Yy]$ ]]; then
        exec $SHELL
    fi
}

function _setup() {
    local EXP="[ $1 $2 ]"
    if eval $EXP; then 
        echo
        read -p "$(color $BOLD "$2 exists. Do you want to override it (y/N)? ")" REPLY
        if [[ ! $REPLY =~ [Yy]$ ]]; then
            color $YELLOW "$2 skipped"
            return 1
        fi
        color $RED "Overriding $2"
        mv $2 "$2.backup"
    fi
    color $GREEN "$2 setup!"
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
