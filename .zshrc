source $HOME/.aliases
source $HOME/.base16_theme
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source $HOME/.zsh/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(
	docker
	docker-compose
	extract
	gem
	kubectl
	pip
	python
	sudo
)

fpath=($HOME/.zsh/zsh-completions/src $fpath)

export FZF_BASE=/usr/bin/fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
autoload -Uz compinit
compinit

export VISUAL=vim
export EDITOR=$VISUAL
export PATH=$PATH:$HOME/bin

if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
zstyle ':completion:*' special-dirs true

HISTFILE=$HOME/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extendedglob

# Can be use for specific environment
source .rc
