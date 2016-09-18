#!/bin/bash
# Chromebook script for Ubuntu based distros on HP Chromebook 14 "Falco"

base_dir="$(dirname $0)"
source_dir="$(dirname $0)/source"

XBINDKEYS_OK=$(dpkg-query -W --showformat='${Status}\n' xbindkeys|grep "install ok installed")

if [[ $XBINDKEYS_OK == "install ok installed" ]]
then
  printf "Installing xbindkeys conf to $HOME/.xbindkeysrc\n"
  /bin/cp $source_dir/.xbindkeysrc $HOME/.xbindkeysrc
  printf "Fixing sleep...\n"
  sudo /bin/cp $SOURCE/unbind_ehci /etc/initramfs-tools/scripts/init-top/unbind_ehci; printf "Copying unbind_ehci to /etc/initramfs-tools/scripts/init-top/...\n"
  sudo /bin/chmod a+x /etc/initramfs-tools/scripts/init-top/unbind_ehci; printf "Setting up permissions...\n"
  sudo /bin/cp $SOURCE/10_disable-ehci.rules /etc/udev/rules.d/10_disable-ehci.rules; printf "copying 10_disable-ehci.rules to /etc/udev/rules.d/...\n"
  sudo /usr/sbin/update-initramfs -k all -u
  sudo /bin/cp /etc/default/grub /etc/default/grub.bak; printf "Creating backup of grub file to /etc/default/grub.bak...\n"
  sudo /bin/cp $source_dir/grub /etc/default/grub; printf "Copying new grub file...\n"
  sudo /usr/sbin/update-grub
  sudo /bin/cp $source_dir/suspend-device-fix.sh /usr/local/sbin/suspend-device-fix.sh; printf "Creating suspend-fix service \n"
  sudo /bin/chmod +x /usr/local/sbin/suspend-device-fix.sh
  sudo /bin/cp $source_dir/suspend-fix.service /etc/systemd/system/suspend-fix.service
  sudo /bin/systemctl enable suspend-fix.service
  printf "Done with sleep fix...\n"
  printf "Making the search key super...\n"
  sudo /bin/cp $source_dir/90-chromebook-keyboard-fix.hwdb /etc/udev/hwdb.d/90-chromebook-keyboard-fix.hwdb
  sudo /sbin/udevadm hwdb --update; printf "Updating hwdb...\n"
  printf "Reboot is needed for search key rebind to take effect!\n"
  exit $?
else
  printf "xbindkeys not installed, installing...\n"
  sudo apt install -y xbindkeys
  sh -c "$base_dir/script.sh"
fi
