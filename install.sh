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

   powerunitDir="powerunit"
   if [ -d "$powerunitDir" ]; then
    whiptail --title "Installation aborted" --msgbox "$powerunitDir already exists, please remove it and restart the installation" 8 78
    exit
   else
    git clone https://github.com/AchimPieters/powerunit.git
   fi

   mkdir /opt/powerunit

   cp $powerunitDir/powerunit.py /opt/powerunit
   if [ ! -f /opt/powerunit/powerunit.py ]; then
     whiptail --title "Installation aborted" --msgbox "There was a problem writing the powerunit.py file" 8 78
    exit
   fi
   cp $powerunitDir/powerunit.service /etc/systemd/system
   if [ ! -f /etc/systemd/system/powerunit.service ]; then
    whiptail --title "Installation aborted" --msgbox "There was a problem writing the powerunit.service file" 8 78
    exit
   fi

   systemctl enable /etc/systemd/system/powerunit.service
   whiptail --title "Installation complete" --msgbox "Power.unit® installation complete. \nThe system will power off. \nCopyright 2019 StudioPieters®" 8 78
   poweroff
fi
