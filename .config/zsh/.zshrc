while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
alias
spectrum
plugins_before
plugins_after
prompt
settings
EOF

# fzf configuration
if [ -f ~/.config/fzf/fzf.zsh ]; then
    source ~/.config/fzf/fzf.zsh
fi

test -f /usr/share/ublue-os/bluefin-cli/bling.sh && source /usr/share/ublue-os/bluefin-cli/bling.sh

dotfile_autoupdate() {
    dotfile add -u && \
    dotfile commit -m "Update $(date +"%Y-%m-%d %H:%M") \
        $(uname -s)/$(uname -m)-$(hostname -s)" && dotfile push
}

dotfile_init() {
	git --no-replace-objects clone --bare --depth 1 -b $(hostname -s)\
        	git@github.com:auralioth/dotfile.git $HOME/.cfg;
    dotfile config --local status.showUntrackedFiles no;
    dotfile checkout -f
}
