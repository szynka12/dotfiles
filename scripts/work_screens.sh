#!/bin/bash

xrandr --output DP-6 \
  --primary          \
  --auto             \
  --rotate normal    \
  --mode 1920x1080   \

xrandr --output DP-4   \
  --auto                \
  --right-of DP-6       \
  --rotate right        \
  --mode 1920x1080      

xrandr --output DP-0 \
  --auto       \
  --left-of DP-6       \
  --mode 1920x1080      

DISPLAY=:0.0 feh --bg-fill /home/sadowski/Pictures/wallpapers/4k-Wallpaper-space.jpg
