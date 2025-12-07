#!/bin/bash

# trap to properly kill container
function shut_down() {
  echo shutting down
  pid=$(pgrep x11vnc)
  kill -SIGTERM "${pid}"
}

trap "shut_down" SIGTERM SIGHUP SIGINT EXIT

RESOLUTION="${RESOLUTION:-1024x768x24}"
PASSWD_FILE="${PASSWD_FILE:-/home/baseuser/.vnc/passwd}"

# remove temporary lock file
rm -f /tmp/.X"${DISPLAY#:}"-lock

# start xvfb on display with resolution
nohup /usr/bin/Xvfb "${DISPLAY}" -screen 0 "${RESOLUTION}" -ac +extension GLX \
  +render -noreset >/dev/null || true &

# Wait for display to become ready
while [[ ! $(xdpyinfo -display "${DISPLAY}" 2>/dev/null) ]]; do
  sleep .3
done

# Start chromium and x11vnc
chromium-browser "${BROWSER_URL}" &
nohup x11vnc -xkb -noxrecord -noxfixes -noxdamage -display "${DISPLAY}" \
  -forever -shared -passwdfile "${PASSWD_FILE}" -rfbport 5900 "$@"
