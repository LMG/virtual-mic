#!/bin/bash

#creates the sink with the default name of VirtualMic
#Usage: ./createMic.sh [micName]
#Outputs: the id of the sink

#Create mic
micNum=$(pactl load-module module-null-sink sink_name=${1:-"VirtualMic"}\
     sink_properties=device.description=${1:-"VirtualMic"})

#Get mic id
micId=$(
pactl list sinks |
awk -v micNum=$micNum '
$1 == "Sink"  {id = $2}
$1 == "Owner" && $3 == micNum {print id; exit}' |
sed -e 's/#//')

if [[ -z $micId ]] ; then
    echo "mic id not found"
    exit 1
fi

echo $micId
