# User Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# ZDOTDIR variable
export ZDOTDIR=$XDG_CONFIG_HOME/shell/zsh

# fcitx5
export XMODIFIERS=@im=fcitx

# Default apps
export EDITOR=nvim
export TERMFM=yazi
export FETCH=fastfetch
export GITMGR=lazygit

if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi
