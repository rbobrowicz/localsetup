#!/bin/bash

# Register with gnome-session so that it does not kill the whole session thinking it is dead.
if [ -n "$DESKTOP_AUTOSTART_ID" ]; then
    dbus-send --print-reply --session --dest=org.gnome.SessionManager "/org/gnome/SessionManager" org.gnome.SessionManager.RegisterClient "string:spectrwm-gnome" "string:$DESKTOP_AUTOSTART_ID"
fi

# Required for i3 and gnome to coexist
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.gnome.gnome-flashback desktop-background true

# Disable built-in notification system for Rofication
gsettings set org.gnome.gnome-flashback notifications false

# Remap default keyboard switch keybindings to avoid collision w/ i3
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Alt><Super>BackSpace']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Alt><Super>BackSpace']"

unclutter -b
#rde-status &
#dwm
stumpwm

# Close session when i3 exits.
if [ -n "$DESKTOP_AUTOSTART_ID" ]; then
    dbus-send --print-reply --session --dest=org.gnome.SessionManager "/org/gnome/SessionManager" org.gnome.SessionManager.Logout "uint32:1"
fi
