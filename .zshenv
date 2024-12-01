# User Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# brew
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
fpath[1,0]="/home/linuxbrew/.linuxbrew/share/zsh/site-functions";
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";

# ZDOTDIR variable
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

command -v nvim >/dev/null 2>&1 && export EDITOR=nvim

# fcitx5
# export XMODIFIERS=@im=fcitx

# TinyTeX ctex can not find Chinese fonts
command -v latex >/dev/null 2>&1 && export OSFONTDIR=/usr/local/share/fonts

if command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"

[ -d "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"
