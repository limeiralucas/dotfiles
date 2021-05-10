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
            DIFF=$(( $LENGTH - $LIMIT + 1 ))
            STEP=$(( 10#$SECOND % $DIFF ))
            SPLIT=$(( $LIMIT - $STEP ))
            SPLIT2=$(( $STEP + $SPLIT ))

            sleep 0.5
            echo "♪ ${TEXT:STEP:SPLIT}${TEXT:SPLIT2:STEP}"
        else
            echo "♪ $TEXT"
        fi
        ;;
    *)
        echo ""
        ;;
esac
