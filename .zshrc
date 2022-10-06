[[ -f $HOME/.rc ]] && source $HOME/.rc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# https://stackoverflow.com/a/10737906
include () {
	[[ -f "$1" ]] && source "$1"
}

autoload -Uz compinit && compinit -i

include $HOME/.p10k.zsh
include $HOME/.zsh/sudo/sudo.plugin.zsh
include $HOME/.zsh/key-bindings/key-bindings.zsh
include $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
include $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
include $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
include $HOME/.zsh/extract/extract.plugin.zsh
include $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
include /usr/share/fzf/completion.zsh
include /usr/share/fzf/key-bindings.zsh
include /usr/share/doc/fzf/examples/completion.zsh
include /usr/share/doc/fzf/examples/key-bindings.zsh
command -v kubectl &> /dev/null && source <(kubectl completion zsh)
fpath=($HOME/.zsh/zsh-completions/src $fpath)

setopt histappend
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extendedglob
setopt globstarshort

zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
zstyle ':completion:*' special-dirs true

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
