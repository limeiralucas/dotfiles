# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ENV
export PATH="$PATH:/usr/local/bin"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -U -g ""'

## Theme
# export PS1="%d %% "

export ZSH_THEME_DIR="$HOME/.config/zsh/themes"
source $ZSH_THEME_DIR/ale-zsh/ale.zsh-theme;

## Bindings
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[^[[C" end-of-line
bindkey "^[^[[D" beginning-of-line
# Vim Home/End
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# Alt arrow
bindkey "^[[1;3C" end-of-line
bindkey "^[[1;3D" beginning-of-line 

## Functions

function testnerd {
    fc-list | grep -i "nerd.*style=Regular" | sed -n "$1p" | cut -d ':' -f2- | xargs | { read arg; eval "urxvt -font 'xft:${arg}:size=11 -e echo ' &"}
}

## Aliases

alias prompt-pwd=pwd
alias v=nvim
alias zshconfig="nvim $HOME/.zshrc"
alias zshreload="source $HOME/.zshrc"
alias ls=exa
alias open=xdg-open
alias urestart="sudo systemctl restart urxvtd@lucas"
alias ustop="sudo systemctl stop urxvtd@lucas"
alias xrreload="xrdb ~/.Xdefaults"
alias testglyph="echo ➜"
alias testpythonglyph="echo "
alias alconfig="nvim $HOME/.config/alacritty/alacritty.yml"
alias setkb="setxkbmap"

## Inits

# pyenv
export PATH="/home/lucas/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# direnv
eval "$(direnv hook zsh)"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Completions

# Enable menu select completion
zstyle ':completion:*' menu select

# Load .zsh files from completions folder
for f in $HOME/.config/zsh/completions/*.zsh; do source $f; done

## Plugins
export ZSH_PLUGIN_DIR="$HOME/.config/zsh/plugins"

# Syntax highlight
source $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh;

# Calculator
source $ZSH_PLUGIN_DIR/calc.plugin.zsh/calc.plugin.zsh;

# Copy-paste
source $ZSH_PLUGIN_DIR/copy-pasta/copy-pasta.plugin.zsh;

# fzf-tab
source $ZSH_PLUGIN_DIR/fzf-tab/fzf-tab.plugin.zsh;

# git aliases
source $ZSH_PLUGIN_DIR/git-aliases/git-aliases.zsh;

# quoter
source $ZSH_PLUGIN_DIR/quoter-zsh/quoter-zsh.plugin.zsh;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/lucas/.sdkman"
[[ -s "/home/lucas/.sdkman/bin/sdkman-init.sh" ]] && source "/home/lucas/.sdkman/bin/sdkman-init.sh"
