# v0.1, touchpad fix not yet included see [Fix touchpad](#fix-touchpad)

Automatic script to fix annoyances when reinstalling an Ubuntu based distribution on a HP Chromebook 14 "Falco"

### What does this script do?

* Fixes sleep
* Fixes keybinds after my own preferences
* (Not Yet) Fixes touchpad after my own preferences

### Fix touchpad
  In /usr/share/X11/xorg.conf.d/50-synaptics.conf under:

    Section "InputClass"
        Identifier "touchpad catchall"
        Driver "synaptics"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"

Add:

    Option "FingerHigh" "9"
    Option "FingerLow" "4"
