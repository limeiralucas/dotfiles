#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

get_volume() {
	SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
	NOW=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9]*\)%.*,\1,' )
	echo $NOW
}

is_muted() {
	MUTED=$( pactl list sinks | grep '^[[:space:]]Mute:' | head -n 1 | tail -n 1 | awk -F ": " '{print $2}' )
	if [ "$MUTED" = "no" ]; then
		echo 0
	else
		echo 1
	fi
}

send_notification() {
	volume=$(get_volume)
	bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')

	if [ "$1" = "mute" ]; then
		is_muted=$(is_muted)
		echo $is_muted
		if [ $is_muted = "1" ]; then
			dunstify -t 1000 -r 2593 -u normal "vol: muted"
		else
			dunstify -t 1000 -r 2593 -u normal "vol: $volume $bar"
		fi
	else
		dunstify -t 1000 -r 2593 -u normal "vol: $volume $bar"
	fi
}

case $1 in
	up)
		volume=$(get_volume)
		if [ $(($volume + 5)) -le 99 ]; then
			pactl set-sink-volume @DEFAULT_SINK@ +5%
		else
			pactl set-sink-volume @DEFAULT_SINK@ 100%
		fi
		send_notification ""
	;;
	down)
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		send_notification ""
	;;
	mute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		send_notification "mute"
	;;
esac
