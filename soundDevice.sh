#!/bin/bash

notification=true 
notificationTime=1
fone="alsa_output.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.analog-stereo"
monitor="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink"
mic="alsa_input.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.mono-fallback"

sendNotify() {
  title=$1
  message=$2
  [[ $notification == true ]] && notify-send -i audio-card "$title" "$message"; sleep $notificationTime 
}

setSink() {
  pacmd set-default-sink $1
  pacmd list-sink-inputs | grep index | while read line 
  do
    pacmd move-sink-input `echo $line | cut -f2 -d' '` $1
  done
}

if [ "$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')" = "$fone" ]; then
    sendNotify "Monitor LG 29WK600" "Microfone Edifier G2 II"
    setSink $monitor
    pactl set-default-source "$mic"
else
    sendNotify "Fone Edifier G2 II" "Microfone Edifier G2 II"
    setSink $fone
    pactl set-default-source "$mic"
fi


