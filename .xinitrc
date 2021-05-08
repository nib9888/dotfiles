#!/bin/sh

if [ -f "~/.Xresources" ]; then
    xrdb -merge ~/.Xresources
fi

. ~/.xprofile &

s6-svc -u ~/.service/slstatus
dbus-launch --exit-with-session dwm
