#!/bin/bash

setxkbmap us

xdotool type --delay 100 "SE80"
xdotool key --delay 100 "Return"

sleep 10

xdotool key "shift+F5"

sleep 3

xdotool type --delay 100 "ZSS18_201_UEBG2_A1"
xdotool key "Return"

sleep 5

xdotool windowactivate $GUI_ID
sleep 1
xdotool key "F8"

sleep 5

xdotool key "F10"
sleep 5
xdotool key "Down"
sleep 0.50s
xdotool key "Down"
sleep 0.50s
xdotool key "Right"
sleep 0.50s
xdotool key "Down"
sleep 0.50s
xdotool key "space"
sleep 5
xdotool key "Down"
sleep 0.50s
xdotool key "Down"
sleep 0.50s
xdotool key "Down"
sleep 0.50s
xdotool key "Down"
sleep 0.50s
xdotool key "space"
sleep 0.50s
xdotool key "Return"

sleep 1
xclip -selection clipboard -o > result.txt
xclip -selection clipboard -o



