#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else

   systemctl stop Powerunit.service
   systemctl disable /etc/systemd/Powerunit.service

   rm /opt/Powerunit/Powerunit.py
   rm /opt/Powerunit -d
   rm /etc/systemd/system/Powerunit.service

   whiptail --title "Uninstall complete" --msgbox "Power.unit® Uninstallation complete. \nThe system will power off. \nCopyright 2019 StudioPieters®.\nYou are safe to remove the folder Power.unit." 8 78
fi
