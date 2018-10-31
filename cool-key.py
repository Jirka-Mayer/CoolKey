#!/usr/bin/env python3
import os
import subprocess
from evdev import InputDevice, ecodes

# store PID to mark the daemon as running
with open(os.path.join(os.path.dirname(__file__), ".daemon-pid"), "w") as pid_file:
    pid_file.write(str(os.getpid()))

# read raw keyboard events from this
dev = InputDevice("/dev/input/by-path/platform-i8042-serio-0-event-kbd")

for event in dev.read_loop():
    if event.type == ecodes.EV_KEY:

        # listen for cool key events
        # keycodes differ from the xmodmap keycodes (this one = 94)
        if event.code == 86:
            if event.value == 1: # keydown
                subprocess.call([os.path.join(os.path.dirname(__file__), "activate.sh")])
            elif event.value == 0: # keyup
                subprocess.call([os.path.join(os.path.dirname(__file__), "disable.sh")])
