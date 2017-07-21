#!/bin/bash

#creates the null sink for the app as well as the loopback connection
#Usage: ./bindApp.sh appName|PID [virtualMicId]
# appName|PID : The name of the program to bind (listen to) or its PID
# virtualMicId : The pulseaudio ID of the virtual mic null sink
#Outputs:
# The ID of the null sink
# The ID of the output loopback
# [The ID of the mic loopback]

#Get the name of the app and the pulseaudio ID of the source
numberExpr='^[0-9]+$'
if [[ -z $1 ]] then
    echo "Usage: ./bindApp.sh appName|PID [virtualMicID]"
    exit 0
elif [[ $1 =~ numberExpr ]] ; then
    appName=$1
    sourceID=
else
    appName=
    sourceID=
fi


#Load output sink
pactl load-module module-null-sink sink_name=$1Output\
 sink_properties=device.description=$1Output
#Connect it to the default output
pactl load-module module-loopback source="$1Output.monitor"
#Change the 
