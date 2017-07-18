#!/bin/bash

#Usage: ./createMic.sh micName
#Outputs: the id of the sink

#create the sink with the default name of VirtualMic
pactl load-module module-null-sink sink_name=${1:-"VirtualMic2"}\
     sink_properties=device.description=${1:-"VirtualMic2"}
