# User Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/share
export XDG_DESKTOP_DIR=$HOME/Desktop
export XDG_DOWNLOAD_DIR=$HOME/Downloads
export XDG_TEMPLATES_DIR=$HOME/Templates
export XDG_PUBLICSHARE_DIR=$HOME/Public
export XDG_DOCUMENTS_DIR=$HOME/Documents
export XDG_MUSIC_DIR=$HOME/Music
export XDG_PICTURES_DIR=$HOME/Pictures
export XDG_VIDEOS_DIR=$HOME/Videos

# ZDOTDIR variable
export ZDOTDIR=$XDG_CONFIG_HOME/shell/zsh

# fcitx5
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# pkglist store
export PKGLIST_DIR=$HOME/.dotfile/pkglist

# Default apps
export EDITOR=nvim
export TERMINAL=foot
export BROWSER=firefox-nightly
export READER=zathura
export FILEMGR=thunar           # file manager
export CODING=code
export TERMFM=yazi              # terminal file manager
export FETCH=fastfetch
export GITMGR=lazygit           # terminal git manager
export MONITOR=btop
export LOCKER=swaylock
export LAUNCHER=rofi

if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi
