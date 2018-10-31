#!/bin/bash

# Activates the keyboard cool state

xmodmap -e "keycode 113 = Home Home Home Home Home"
xmodmap -e "keycode 114 = End End End End End"
xmodmap -e "keycode 111 = Prior Prior Prior Prior Prior"
xmodmap -e "keycode 116 = Next Next Next Next Next"
