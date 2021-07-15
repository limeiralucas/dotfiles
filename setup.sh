#!/bin/sh

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ ! -f $HOME/.tmux.conf ]; then
    echo "Setup tmux config"
    ln -s $SCRIPTPATH/tmux/tmuxconf $HOME/.tmux.conf
fi

if [ ! -f $HOME/.zshrc ]; then
    echo "Setup zsh config"
    ln -s $SCRIPTPATH/zsh/zshrc $HOME/.zshrc

    rm -f $HOME/.zprofile
    echo 'source $HOME/.zshrc' >> $HOME/.zprofile
fi
