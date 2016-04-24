# v0.1 Released, touchpad fix not yet included see [Fix touchpad](#1)

## Automatic script to fix annoyances when reinstalling an Ubuntu based distribution on a HP Chromebook 14 "Falco"
### Can probably be used on a live-cd
### This script will:

* Fix sleep
* (Not Yet) Fix touchpad after my own preferences
* Fix keybinds after my own preferences

[1]
  In /usr/share/X11/xorg.conf.d/50-synaptics.conf under:

    Section "InputClass"
        Identifier "touchpad catchall"
        Driver "synaptics"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"

Add:

    Option "FingerHigh" "9"
    Option "FingerLow" "4"
