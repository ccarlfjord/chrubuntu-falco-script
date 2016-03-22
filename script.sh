#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

sudo -u root
cp ./unbind_ehci /etc/initramfs-tools/scripts/init-top/unbind_ehci &&
chmod a+x etc/initramfs-tools/scripts/init-top/unbind_ehci &&
cp ./10_disable-ehci.rules /etc/udev/rules.d/10_disable-ehci.rules &&
update-initramfs -k all -u &&
cp /etc/default/grub /etc/default/grub.bak &&
cp ./grub /etc/default/grub &&
update-grub &&
exit

if [[ $XBINDKEYS_OK == "install ok installed" ]]; then

fi
