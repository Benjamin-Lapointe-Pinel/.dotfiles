autoload -Uz compinit && compinit -i

source $HOME/.base16_theme
source $HOME/.aliases
source $HOME/.zsh/sudo/sudo.plugin.zsh
source $HOME/.zsh/key-bindings/key-bindings.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source $HOME/.zsh/extract/extract.plugin.zsh
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
fpath=($HOME/.zsh/zsh-completions/src $fpath)

export PATH=$PATH:$HOME/bin

setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extendedglob

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
zstyle ':completion:*' special-dirs true

# https://unix.stackexchange.com/a/38941
# function cd {
# 	builtin cd $@
# 	pwd > $HOME/last_dir
# }
# if [ -f $HOME/.last_dir ]
# 	then cd `cat $HOME/.last_dir`
# fi

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}

# Can be use for specific environment
[[ ! -f $HOME/.rc ]] || source $HOME/.rc

if command -v neofetch &> /dev/null; then neofetch; fi
