#!/bin/bash
# shellcheck source=scripts/functions.sh
source "/home/babo/server/functions.sh"

LogAction "Setting file permissions"

if [ -z "${PUID}" ] || [ -z "${PGID}" ]; then
    LogError "PUID and PGID not set. Please set these in the environment variables."
    exit 1
else
    usermod -o -u "${PUID}" babo
    groupmod -o -g "${PGID}" babo
fi

chown -R babo:babo /home/babo/

cat /branding

LogAction "Starting BaboViolent 2 Dedicated Server"

# shellcheck disable=SC2317
term_handler() {
    LogWarn "SIGTERM received, shutting down server"
    kill -SIGTERM "$(pidof BaboViolentDedicated)" 2>/dev/null
    tail --pid="$killpid" -f 2>/dev/null
}

trap 'term_handler' SIGTERM

# Start the server
/home/babo/server/start.sh &

# Process ID
killpid="$!"
wait "$killpid"
