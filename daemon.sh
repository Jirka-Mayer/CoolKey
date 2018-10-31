#!/bin/sh

# folder of the cloned repository
REPO_FOLDER="REPO_FOLDER_HERE"
USER_FOLDER="USER_FOLDER_HERE"

# output logging
STANDARD_OUTPUT="/dev/null"
ERROR_OUTPUT=$REPO_FOLDER"/errors.log"

# file with PID of the running daemon
PID_FILE=$REPO_FOLDER"/.daemon-pid"

case "$1" in
  
    start)
        if [ ! -f $PID_FILE ]; then
            echo "Starting CoolKey daemon..."
            cd $REPO_FOLDER
            
            # allow root, running this service, to call the xmodmap command
            export DISPLAY=":0"
            export XAUTHORITY="$USER_FOLDER/.Xauthority"

            ./cool-key.py 1>> $STANDARD_OUTPUT 2>> $ERROR_OUTPUT &
        else
            echo "Daemon is already running."
        fi
        ;;
  
    stop)
        if [ -f $PID_FILE ]; then
            echo "Stopping CoolKey daemon..."
            PID=$(cat $PID_FILE)
            rm $PID_FILE
            kill $PID
        else
            echo "Daemon is not even running."
        fi
        ;;

    status)
        if [ -f $PID_FILE ]; then
            echo "Running"
            exit 0
        else
            echo "Stopped"
            exit 1
        fi
        ;;
  
    *)
        echo "Usage: /etc/init.d/cool-key {start|stop}"
        exit 1
        ;;

esac

exit 0