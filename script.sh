#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"
SOURCE="`dirname $0`/source"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

sudo cp $SOURCE/unbind_ehci /etc/initramfs-tools/scripts/init-top/unbind_ehci &&
sudo chmod a+x etc/initramfs-tools/scripts/init-top/unbind_ehci &
sudo cp $SOURCE/10_disable-ehci.rules /etc/udev/rules.d/10_disable-ehci.rules &&
sudo update-initramfs -k all -u &&
sudo cp /etc/default/grub /etc/default/grub.bak &&
sudo cp $SOURCE/grub /etc/default/grub &&
sudo update-grub &&

if [[ $XBINDKEYS_OK == "install ok installed" ]]; then
  cp $SOURCE/.xbindkeysrc $HOME/.xbindkeysrc &
  cp $SOURCE/.Xmodmap $HOME/.Xmodmap
fi
