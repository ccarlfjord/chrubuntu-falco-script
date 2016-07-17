#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"

BASE_DIR=`dirname $0`
SOURCE="`dirname $0`/source"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

if [[ $XBINDKEYS_OK = "install ok installed" ]]
then
  cp $SOURCE/.xbindkeysrc $HOME/.xbindkeysrc &
  cp $SOURCE/.Xmodmap $HOME/.Xmodmap
  sudo cp $SOURCE/unbind_ehci /etc/initramfs-tools/scripts/init-top/unbind_ehci; printf "Copying unbind_ehci to /etc/initramfs-tools/scripts/init-top/...\n"&&
  sudo chmod a+x /etc/initramfs-tools/scripts/init-top/unbind_ehci; printf "Setting up permissions...\n" &
  sudo cp $SOURCE/10_disable-ehci.rules /etc/udev/rules.d/10_disable-ehci.rules; printf "copying 10_disable-ehci.rules to /etc/udev/rules.d/...\n" &&
  sudo update-initramfs -k all -u &&
  sudo cp /etc/default/grub /etc/default/grub.bak; printf "Creating backup of grub file to /etc/default/grub.bak...\n" &&
  sudo cp $SOURCE/grub /etc/default/grub; printf "Copying new grub file...\n" &&
  sudo update-grub
  sudo cp $SOURCE/suspend-device-fix.sh /usr/local/sbin/suspend-device-fix.sh; printf "Creating suspend-fix service \n"
  sudo chmod +x /usr/local/sbin/suspend-device-fix.sh
  sudo cp $SOURCE/suspend-fix.service /etc/systemd/system/suspend-fix.service
  sudo systemctl enable suspend-fix.service
else
  printf "xbindkeys not installed, installing...\n"; sudo apt-get install xbindkeys && $BASE_DIR/script.sh
fi
