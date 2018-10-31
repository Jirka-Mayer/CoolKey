CoolKey
=======

Turn a boring keyboard key into a cool and useful key.

This set of scripts allows you to turn a key on your keyboard into a cool key,
that when pressed turns your keyboard into cool state. That means it remaps keys
however you like.

In my case I use it to turn arrows into home/end/pageup/pagedown when I press the key between left shift and the letter Z. Not all keyboards have this key. I didn't use it.

It runs on Ubuntu with xorg, but probably not on anything else... If it makes your computer explode, I warned you.

## Installation

You need to have python3 and the `evdev` package.

Clone the repository somewhere and keep it there. Make all the necessary scripts executable:

    sudo chmod +x install.sh uninstall.sh cool-key.py activate.sh disable.sh prepare.sh

Run the install script (and you have to be inside the repo folder!)

    sudo ./install.sh

Restart your PC and hope it works.

## How it works

Installation registers a `cool-key` service (daemon). The daemon is the `cool-key.py` script. That script listens for raw keyboard events. When the cool key is pressed, it runs the `activate.sh` script. When it's relased, it runs the `disable.sh` script. To disable the cool key deafult behaviour the `prepare.sh` script is run. It is run from `~/.xsessionrc`. It cannot be run from the deamon on stratup, because the xorg is not running yet.
