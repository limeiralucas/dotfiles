get_brightness() {
	echo $(xbacklight -get) | awk -F "." '{print $1}'
}

send_notification() {
	brightness=$(get_brightness)
	bar=$(seq -s "─" $(($brightness / 5)) | sed 's/[0-9]//g')

	dunstify -t 1000 -r 2593 -u normal " $brightness $bar"
}

if [ "$1" == "up" ]; then
	xbacklight -inc 5
	send_notification
else
	xbacklight -dec 5
	send_notification
fi
