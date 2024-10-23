#!/usr/bin/env bash

# dotfile 中用到的 submodules
# 用于 submodules 不正常或重新制作 dotfile 时

git submodule add https://github.com/seebi/dircolors-solarized shell/plugins/dircolors-solarized
git submodule add https://github.com/zsh-users/zsh-syntax-highlighting shell/plugins/zsh-syntax-highlighting
git submodule add https://github.com/zsh-users/zsh-completions shell/plugins/zsh-completions
git submodule add https://github.com/zsh-users/zsh-autosuggestions shell/plugins/zsh-autosuggestions
# git submodule add git@github.com:auralioth/nvim.git
