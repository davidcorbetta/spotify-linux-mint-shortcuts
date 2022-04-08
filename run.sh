#!/bin/bash

notification=true

sendNotify () {
  [[ $notification == true ]] && notify-send -i spotify "$1" "$2"
}

sendCommand () {
  dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
  sleep 0.2

  #album=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "album"|egrep -v "album"|egrep -v "array"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
  artist=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$`
  title=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`

  sendNotify "${artist}: ${title}" "$1" 
}



if [ $1 = "-" ] || [ $1 = "+" ]; then
  # Volume control
  playback_input=`pactl list sink-inputs short | awk '{print $1}' | head -1` && pactl set-sink-input-volume $playback_input $15%
  if [ $1 = "-" ]; then
    sendNotify "Volume +5%"
  else
    sendNotify "Volume -5%" 
  fi
else
  sendCommand $1
fi