#!/bin/bash

notification=true

sendNotify () {
  title=$1
  message=$2
  [[ $notification == true ]] && notify-send -i spotify "$title" "$message"
}

sendCommand () {
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
  sleep 0.4

  base="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|"
  tit="egrep -A 1 \"title\" |egrep -v \"title\" |cut -b 44-|cut -d '\"' -f 1|egrep -v ^$"
  art="egrep -A 2 \"artist\"|egrep -v \"artist\"|egrep -v \"array\"|cut -b 27-|cut -d '\"' -f 1|egrep -v ^$"
  #alb="egrep -A 2 \"album\" |egrep -v \"album\" |egrep -v \"array\"|cut -b 44-|cut -d '\"' -f 1|egrep -v ^$"
  
  artist=`eval $base $art`
  title=`eval $base $tit`
  
  sendNotify "${artist}: ${title}" "$1" 
}

if [ $1 = "-" ] || [ $1 = "+" ]; then
  # Volume control
  playback_input=`pactl list sink-inputs short | awk '{print $1}' | head -1` && pactl set-sink-input-volume $playback_input $15%
  sendNotify "Volume ${1}5%" 
else
  sendCommand $1
fi
