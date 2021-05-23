#!/bin/bash

LIMIT=35
STATUS=$(playerctl --ignore-player=chromium status 2> /dev/null)
TRUNCATE=1

case $STATUS in
    Playing | Paused)
        ARTIST=$(playerctl metadata artist)
        TITLE=$(playerctl metadata title)
        TEXT="$TITLE - $ARTIST"
        LENGTH=${#TEXT}

        if [ $LENGTH -gt $LIMIT ]; then
            if [ $TRUNCATE -eq 1 ]; then
                INDEX=$(( $LIMIT - 3 ))
                echo "♪ ${TEXT:0:INDEX}..."
            else
                SECOND=$(date +%S)
                DIFF=$(( $LENGTH - $LIMIT + 1 ))
                STEP=$(( 10#$SECOND % $DIFF ))
                SPLIT=$(( $LIMIT - $STEP ))
                SPLIT2=$(( $STEP + $SPLIT ))

                echo "♪ ${TEXT:STEP:SPLIT}${TEXT:SPLIT2:STEP}"
            fi
        else
            echo "♪ $TEXT"
        fi
        ;;
    *)
        echo ""
        ;;
esac
