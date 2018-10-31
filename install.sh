#!/bin/sh

DAEMON="cool-key"
TARGET_DAEMON_FILE="/etc/init.d/$DAEMON"
REPO_FOLDER=$(pwd)
USER_FOLDER=$(realpath ~)
XSESSIONRC="$USER_FOLDER/.xsessionrc"
PREPARE_COMMAND='sleep 5 && . "'$REPO_FOLDER'/prepare.sh" &'

# check to make sure we don't overwrite something we don't want to overwrite
if [ -f "$TARGET_DAEMON_FILE" ]; then
    echo "File already exists: $TARGET_DAEMON_FILE"
    exit 0
fi

# copy the daemon file and fill out important variables
awk '{gsub(/REPO_FOLDER_HERE/, "'$REPO_FOLDER'"); gsub(/USER_FOLDER_HERE/, "'$USER_FOLDER'"); print;}' ./daemon.sh > $TARGET_DAEMON_FILE

# rights, rights, rights
chmod 755 "$TARGET_DAEMON_FILE"

# register stuff
update-rc.d "$DAEMON" defaults

# add stuff to .xsessionrc
if grep -Fxq "$PREPARE_COMMAND" "$XSESSIONRC"; then
    echo "Preparation command is already registered."
else
    echo "Registering preparation command..."
    
    echo "" >> "$XSESSIONRC"
    echo "# CoolKey code:" >> "$XSESSIONRC"
    echo "$PREPARE_COMMAND" >> "$XSESSIONRC"
    echo "" >> "$XSESSIONRC"
fi
