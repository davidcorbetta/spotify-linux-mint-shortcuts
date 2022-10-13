#!/bin/bash

notification=true
notificationTime=2
monitorDevice=false

sendNotify () {
  title=$1
  message=$2
  [[ $notification == true ]] && notify-send -i display "$title" "$message"; sleep $notificationTime 
}
# remove tudo que estive antes e depois da resolução
resolution=`xrandr | grep " connected" |  grep "HDMI" | sed "s/.*primary //" | sed "s#+.*##"`

# Desliga tela do note
[[ $monitorDevice == false ]] && xrandr --output eDP-1 --off

if [[ "1920x1080" == $resolution  ]]; then
  sendNotify "Changing resolution to 2560x1080"
  xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "HDMI"` --mode 2560x1080 --left-of DP-1 --pos 0x0
  xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "DP-1"` --auto 
  #xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "DP-1"` --auto --pos 2560x0
else
  sendNotify "Changing resolution to 1920x1080"
  xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "HDMI"` --mode 1920x1080 --left-of DP-1 --pos 0x0
  xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "DP-1"` --auto 
  #xrandr --output `xrandr | grep " connected" | cut -f1 -d" " | grep "DP-1"` --auto --pos 1920x0
fi
