#!/bin/bash

ARTIST=$(playerctl metadata artist)
TITLE=$(playerctl metadata title)

echo "$ARTIST - $TITLE"
