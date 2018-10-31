#!/bin/bash

# Disables the keyboard cool state (remaps back to default)

xmodmap -e "keycode 113 = Left Left Left Left Left"
xmodmap -e "keycode 114 = Right Right Right Right Right"
xmodmap -e "keycode 111 = Up Up Up Up Up"
xmodmap -e "keycode 116 = Down Down Down Down Down"
