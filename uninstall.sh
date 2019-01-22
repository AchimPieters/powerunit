#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else

   systemctl stop powerunit.service
   systemctl disable /etc/systemd/powerunit.service

   rm /opt/powerunit/powerunit.py
   rm /opt/powerunit -d
   rm /etc/systemd/system/powerunit.service
   rm -rf powerunit

   whiptail --title "Uninstall complete" --msgbox "Power.unit® Uninstallation complete. The system will power off. \nCopyright 2019 StudioPieters®. You are safe to remove the folder Power.unit." 8 78
fi
