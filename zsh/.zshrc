# Autocompletion enabled
autoload -Uz compinit
compinit

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
alias alconfig="nvim $HOME/.config/alacritty/alacritty.yml"
alias setkb="setxkbmap"
alias pipclean="pip freeze | xargs pip uninstall -y"
alias battery-status="upower -i /org/freedesktop/UPower/devices/battery_BAT0"

## Inits

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"

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
source $ZSH_PLUGIN_DIR/oh-my-git-aliases/oh-my-git-aliases.sh;

# quoter
source $ZSH_PLUGIN_DIR/quoter-zsh/quoter-zsh.plugin.zsh;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/lucas/.sdkman"
[[ -s "/home/lucas/.sdkman/bin/sdkman-init.sh" ]] && source "/home/lucas/.sdkman/bin/sdkman-init.sh"

