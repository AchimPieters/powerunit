#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else

   systemctl stop Power.unit.service
   systemctl disable /etc/systemd/Power.unit.service

   rm /opt/Power.unit/Power.unit.py
   rm /opt/Power.unit -d
   rm /etc/systemd/system/Power.unit.service

   whiptail --title "Uninstall complete" --msgbox "Power.unit® Uninstallation complete. \nThe system will power off. \nCopyright 2019 StudioPieters®.\nYou are safe to remove the folder Power.unit." 8 78
fi
