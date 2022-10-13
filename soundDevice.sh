#!/bin/bash

notification=true 
notificationTime=1

sendNotify () {
  title=$1
  message=$2
  [[ $notification == true ]] && notify-send -i audio-card "$title" "$message"; sleep $notificationTime 
}

if [ "$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')" = "alsa_output.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.analog-stereo" ]; then
    sendNotify "Monitor LG 29WK600" "Microfone Edifier G2 II"
    pactl set-default-sink "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink"
    pacmd move-sink-input "12" "alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_3__sink"
    pactl set-default-source "alsa_input.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.mono-fallback"
else
    sendNotify "Fone Edifier G2 II" "Microfone Edifier G2 II"
    pactl set-default-sink "alsa_output.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.analog-stereo"
    pacmd move-sink-input "12" "alsa_output.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.analog-stereo"
    pactl set-default-source "alsa_input.usb-BY_EDIFIER_EDIFIER_G2_II_GAMING_HEADSET_20190628-00.mono-fallback"
fi


