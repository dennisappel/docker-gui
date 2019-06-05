#!/bin/bash

echo "Starting Xserver..."
Xvfb :99 -pixdepths 8 10 16 -screen 0 1280x720x24 &
export DISPLAY=:99

COUNT=0
MAX_TRIES=30
while ! xdpyinfo >/dev/null 2>&1; do
	sleep 0.50s
	COUNT=$(( COUNT + 1))
	if [ "${COUNT}" -ge "${MAX_TRIES}" ]; then
		echo "Timeout when starting Xserver"
		exit 1
	fi
done

echo "Xserver started..."
echo "Starting openbox..."
openbox-session >/dev/null 2>&1 &

echo "Starting GUI..."
/scripts/client.sh
until xdotool search --name R87 >/dev/null 2>&1; do
	sleep 1
done

/scripts/monitoring.sh &
sleep 1

echo "Setting trust level..."
xdotool key "Tab"
sleep 1
xdotool key "space"

until xdotool search --name "R87 \(1\) \(101\)" >/dev/null 2>&1; do
	sleep 1
done
echo "GUI started"

export GUI_ID=$(xdotool search --name "R87 \(1\) \(101\)")
echo "Starting Daemon..."
/scripts/daemon.sh

#xdotool windowkill $GUI_ID

