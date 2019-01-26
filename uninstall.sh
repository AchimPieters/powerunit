#!/usr/bin/env bash

# Project name: Powerunit®
# Project URI:  https://www.studiopieters.nl/raspberry-pi-power-unit
# Description: Powerunit® - Raspberry Pi® Uninstall Script
# Version: 4.7.2
# License: MIT - Copyright 2019 StudioPieters® (https://opensource.org/licenses/MIT)

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

   whiptail --title "Uninstall complete" --msgbox "Powerunit® Uninstallation complete. The system will power off. \nCopyright 2019 StudioPieters®" 8 78
fi
