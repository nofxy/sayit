#!/bin/bash
#
# This uses the Google translate web service to convert text to speech.
# If there is no internet connection (Checks by pinging an external IP),
# then it will default to pico2wave (found in libttspico-utils in Debian).

#
# Dependencies:
# mplayer - to play back audio 

# Google translate service
mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=en&q=ambidextrous" &> /dev/null
