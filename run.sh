#!/bin/bash


# Volume
if [ $1 = "-" ] || [ $1 = "+" ]; then
  playback_input=`pactl list sink-inputs short | awk '{print $1}' | head -1` && pactl set-sink-input-volume $playback_input $15%
  if [ $1 = "-" ]; then
    notify-send --urgency=low -i "audio-volume-low" "Volume"
  else
    notify-send --urgency=low -i "audio-volume-high" "Volume"
  fi
fi

# next
if [ $1 = ">>" ]; then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
fi

# Previous
if [ $1 = "<<" ]; then
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
fi

# Play
if [ $1 = ">" ]; then
    notify-send --urgency=low -i "media-playback-start" "Play"
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
fi

# Pause
if [ $1 = "||" ]; then
    notify-send --urgency=low -i "media-playback-stop" "Stop"
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
fi