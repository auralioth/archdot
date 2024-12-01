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
