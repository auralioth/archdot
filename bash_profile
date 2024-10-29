export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# export XMODIFIERS=@im=fcitx

export EDITOR=nvim

# TinyTeX ctex can not find Chinese fonts
export OSFONTDIR=/usr/local/share/fonts

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

if [ -d "$HOME/bin" ]; then
  export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

alias vi=nvim
alias f=yazi
alias lg=lazygit
alias n=fastfetch
alias q=exit
alias su="su -l"
