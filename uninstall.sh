#!/bin/sh

DAEMON="cool-key"
TARGET_DAEMON_FILE="/etc/init.d/$DAEMON"
REPO_FOLDER=$(pwd)
USER_FOLDER=$(realpath ~)
XSESSIONRC="$USER_FOLDER/.xsessionrc"

# stop the daemon if running
"$TARGET_DAEMON_FILE" stop

# unregister the daemon
update-rc.d "$DAEMON" remove

# remove the daemon handling file
rm "$TARGET_DAEMON_FILE"

# remove stuff from .xsessionrc
if grep -Fq "$REPO_FOLDER" "$XSESSIONRC"; then
    echo "Removing preparation command call..."
    mv "$XSESSIONRC" "$XSESSIONRC.old"
    grep -Fv "$REPO_FOLDER" "$XSESSIONRC.old" > "$XSESSIONRC"
else
    echo "Preparation command not found inside the .xsessionrc file."
fi
