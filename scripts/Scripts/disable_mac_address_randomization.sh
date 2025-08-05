#!/bin/bash
nmcli connection modify "SSID NAME" wifi.cloned-mac-address permanent
nmcli connection modify "SSID NAME" wifi.mac-address-randomization never
