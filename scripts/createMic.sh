#!/bin/bash

#creates the sink with the default name of VirtualMic
#Usage: ./createMic.sh micName
#Outputs: the id of the sink

pactl load-module module-null-sink sink_name=${1:-"VirtualMic"}\
     sink_properties=device.description=${1:-"VirtualMic"}
