#!/usr/bin/env bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

if [ ! $? = 0 ]; then
   exit 1
else
   apt-get install -y git whiptail # Installing whiptail to display dialog boxes from shell scripts.

   PowerunitDir="Power.unit"
   if [ -d "$PowerunitDir" ]; then
    whiptail --title "Installation aborted" --msgbox "$PowerunitDir already exists, please remove it and restart the installation" 8 78
    exit
   else
    git clone https://github.com/AchimPieter/Power.unit.git
   fi

   mkdir /opt/Power.unit

   cp $PowerunitDir/power.unit.py /opt/Power.unit
   if [ ! -f /opt/Power.unit/Power.unit.py ]; then
     whiptail --title "Installation aborted" --msgbox "There was a problem writing the Power.unit.py file" 8 78
    exit
   fi
   cp $PowerunitDir/Power.unit.service /etc/systemd/system
   if [ ! -f /etc/systemd/system/Power.unit.service ]; then
    whiptail --title "Installation aborted" --msgbox "There was a problem writing the Power.unit.service file" 8 78
    exit
   fi

   systemctl enable /etc/systemd/system/Power.unit.service
   whiptail --title "Installation complete" --msgbox "Power.unit® installation complete. \nThe system will power off. \nCopyright 2019 StudioPieters®" 8 78
   poweroff
fi
