#!/bin/sh
xrandr --output VGA1  --mode 1368x768_60.00 &
feh --bg-scale ~/Wallpaper/Aesthetics.jpg
i3 gaps inner all set 11 &

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar JIBON  &


compton &





