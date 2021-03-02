#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source $HOME/.base16_theme
source $HOME/.aliases
source $HOME/.env

export PATH=$PATH:$HOME/bin

# Can be use for specific environment
[[ ! -f $HOME/.rc ]] || source $HOME/.rc
