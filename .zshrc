# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOME/.aliases
source $HOME/.base16_theme
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme


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
export FZF_BASE=/usr/bin/fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
autoload -Uz compinit
compinit
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
fpath=($HOME/.zsh/zsh-completions/src $fpath)

PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

HISTFILE=$HOME/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

setopt extendedglob
