#!/bin/bash

COMPOSITOR=picom
RUN_CMD="picom --no-fading-openclose &"

if [[ $(ps -ef | grep -c "$COMPOSITOR") -ne 1 ]]; then
    pkill $COMPOSITOR && notify-send "Compositor killed" -t 3000
else
    eval $RUN_CMD && notify-send "Compositor running" -t 3000
fi
