#!/bin/bash
#
# This uses the Google translate web service to convert text to speech.
# If there is no internet connection (Checks by pinging an external IP),
# then it will default to pico2wave (found in libttspico-utils in Debian).

#
# Dependencies:
# mplayer - to playback audio for google translate tts
# pico2wave - to playback audio if network is down

# Google translate service
say() {
	if [[ "${1}" =~ -[a-z]{2} ]]
	then
		local lang=${1#-}
		local text="${*#$1}"
	else
		local lang=${LANG%_*}
		local text="$*"
	fi

mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null
}

picotts () {
DISPLAY=:0.0 pico2wave -l=en-US -w=/tmp/picotts.wav "$1"
aplay /tmp/picotts.wav 2>&1 > /dev/null
rm /tmp/picotts.wav
}

# Checks internet connection 1 time
net_check () {
	if ping -c 1 8.8.8.8 > /dev/null
		then
			return 0 
		else
			return 1
	fi
}

if net_check 
then
	say "$1"
else
	picotts "$1"
fi
