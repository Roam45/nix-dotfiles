#!/usr/bin/env/bash

#init wallpaper
swww-daemon &
#set wallpaper
swww img ~/Wallpapers/gruvbox-nix.png &

#bar
export HYPRLAND_INSTANCE_SIGNATURE=$(ls -w1 /tmp/hypr | tail -1)
waybar &

#mako
mako &
