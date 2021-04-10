#!/bin/bash

ARTIST=$(playerctl metadata artist)
TITLE=$(playerctl metadata title)

echo "$TITLE - $ARTIST" | cut -c -35 | awk '{print $0"..."}'
