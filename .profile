if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

[[ -f $HOME/.profile_custom ]] && source $HOME/.profile_custom
