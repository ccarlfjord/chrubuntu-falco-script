#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"
SOURCE="`pwd`/source"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

sudo -u root
cp $F/unbind_ehci /etc/initramfs-tools/scripts/init-top/unbind_ehci &&
chmod a+x etc/initramfs-tools/scripts/init-top/unbind_ehci &
cp $F/10_disable-ehci.rules /etc/udev/rules.d/10_disable-ehci.rules &&
update-initramfs -k all -u &&
cp /etc/default/grub /etc/default/grub.bak &&
cp $F/grub /etc/default/grub &&
update-grub &&
exit

if [[ $XBINDKEYS_OK == "install ok installed" ]]; then
  cp $F/.xbindkeysrc $HOME/.xbindkeysrc &
  cp $F/.Xmodmap $HOME/.Xmodmap
fi
