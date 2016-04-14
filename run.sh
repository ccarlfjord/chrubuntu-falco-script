#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"
SOURCE="`dirname $0`/source"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

sudo cp /etc/default/grub /etc/default/grub.bak &&
sudo cp $SOURCE/grub /etc/default/grub &&
sudo update-grub &&
sudo cp $SOURCE/suspend-device-fix.sh /usr/local/sbin/suspend-device-fix.sh &&
sudo chmod +x /usr/local/sbin/suspend-device-fix.sh &
sudo cp $SOURCE/suspend-fix.service /etc/systemd/system/suspend-fix.service
sudo systemctl enable suspend-fix.service

if [ -f /etc/rc.d/rc.local ] # kolla efter rc.d och grepa efter echo strängen annars skriv in echo strängen längst ner
  then grep
sudo echo "echo 1 > /sys/devices/pci0000\:00/0000\:00\:1d.0/remove" >> /etc/rc.d/rc.local

if [[ $XBINDKEYS_OK == "install ok installed" ]]; then
  cp $SOURCE/.xbindkeysrc $HOME/.xbindkeysrc &
  cp $SOURCE/.Xmodmap $HOME/.Xmodmap
fi
