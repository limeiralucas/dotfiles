#!/bin/bash

LIMIT=35
STATUS=$(playerctl status 2> /dev/null)

case $STATUS in
    Playing | Paused)
        ARTIST=$(playerctl metadata artist)
        TITLE=$(playerctl metadata title)
        TEXT="$TITLE - $ARTIST"
        LENGTH=${#TEXT}

        if [ $LENGTH -gt $LIMIT ]; then
            SECOND=$(date +%S)
            STEP=$(( 10#$SECOND % $LIMIT ))

            echo "${TEXT:STEP:LENGTH} | ${TEXT:0:STEP}"
        else
            echo $TEXT
        fi
        break
        ;;
    *)
        echo ""
        ;;
esac
