#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "2wx" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_rotary_poti import RotaryPoti

# Callback function for position callback (parameter has range -150 to 150)
def cb_position(position):
    print('Position: ' + str(position))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    poti = RotaryPoti(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set Period for position callback to 0.05s (50ms)
    # Note: The position callback is only called every 50ms if the 
    #       position has changed since the last call!
    poti.set_position_callback_period(50)

    # Register position callback to function cb_position
    poti.register_callback(poti.CALLBACK_POSITION, cb_position)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
