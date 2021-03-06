#!/bin/bash

#Connects a binded app to a created virtual mic
#Usage: ./connectToMic.sh appOutputId virtualMicId
# appOutputId : The pulseaudio ID of the 
#                virtual sink of the app 
# virtualMicId : The pulseaudio ID of the virtual mic null sink
#Outputs:

#Get name of appOutput 
if [[ -z $1 || -z $2 ]] ; then
    echo "Usage: ./connectToMic.sh appOutputId virtualMicId"
    exit 1
fi
echo "$0 $1 $2"
outputId=$1
outputName=$(
pactl list short sinks |
awk -v outputId=$outputId '
$1 == outputId {print $2; exit}')
 
echo $outputId
if [[ -z $outputId ]] ; then
    echo "Output id not found"
    exit 1
fi

pactl load-module module-loopback source=${outputName}.monitor sink=$2
