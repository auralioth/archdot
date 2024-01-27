#!/bin/bash

wget -qO- "https://yihui.org/tinytex/install-bin-unix.sh" | sh

# 必须确保~/.local/bin在PATH中
source ~/.zshenv

tlmgr install $(cat ../tinytex-pkgs.txt | tr '\n' ' ')

# 确保TEXMFHOME为~/texmf
tlmgr conf texmf --delete TEXMFHOME
