#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
userresources_custom=$HOME/.Xresources_custom
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$userresources_custom" ]; then
    xrdb -merge "$userresources_custom"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# keyboard layouts
setxkbmap -layout us,ca -option grp:win_space_toggle

# background
hsetroot -solid "#$(xrdb -query | grep "*color19:" | cut -f 2 | cut -c2- | tr '[:lower:]' '[:upper:]')"
$HOME/.fehbg &

numlockx &

urxvtd --quiet --opendisplay --fork && export TERMINAL=urxvtc

exec i3
