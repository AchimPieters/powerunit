#!/usr/bin/env python

# Import the modules to send commands to the system and access GPIO pins.
from subprocess import call
import RPi.GPIO as GPIO
from time import sleep

# Map PinEleven and PinThirteen on the Power.unit PCB to chosen pins on the Raspberry Pi header.
# The PCB numbering is a legacy with the original design of the board.
PinEleven = 11
PinThirteen = 13
GPIO.setmode(GPIO.BOARD) # Set pin numbering to board numbering.
GPIO.setup(PinEleven, GPIO.IN) # Set up PinEleven as an input.
GPIO.setup(PinThirteen, GPIO.OUT, initial=1) # Setup PinThirteen as output for the LED.

while (GPIO.input(PinEleven) == True): # While button not pressed
 GPIO.wait_for_edge(PinEleven, GPIO.RISING) # Wait for a rising edge on PinSeven
 sleep(0.1); # Sleep 100ms to avoid triggering a shutdown when a spike occured


if (GPIO.input(PinEleven) == True):
 GPIO.output(PinThirteen,0) # Bring down PinThirteen so that the LED will turn off.
 call('poweroff', shell=False) # Initiate OS Poweroff
else:
 call('reboot', shell=False) # Initiate OS Reboot
