#!/bin/bash

#creates the null sink for the app as well as the loopback connection
#Usage: ./bindApp.sh appName|PID [virtualMicId]
# appName|PID : The name of the program to bind (listen to) or its PID
# virtualMicId : The pulseaudio ID of the virtual mic null sink
#Outputs: 
# The ID of the output loopback
# [The ID of the mic loopback]

#Get the name of the app and the pulseaudio ID of the source
numberExpr="^[0-9]+$"
if [[ -z $1 ]] ; then
    echo "Usage: ./bindApp.sh appName|PID [virtualMicID]"
    exit 1
elif [[ $1 =~ numberExpr ]] ; then
    echo "a number"
    appName=$(ps -p $1 -o comm=)
    pid=$1
else
    appName=$1
    pid=$(pgrep $1)
    if [[ -z $pid ]] ; then
      echo "pid not found"
      exit 1
    fi
fi

#Load output sink
outputNum=$(pactl load-module module-null-sink sink_name=${appName}Output\
 sink_properties=device.description=${appName}Output)

if [[ -z $outputNum ]] ; then
    echo "Can't create output sink"
    exit 1
fi

#Connect it to the default output
wiring=$(pactl load-module module-loopback source="${appName}Output.monitor")

if [[ -z $wiring ]] ; then
   echo "Couldn't connect sink to default output"
   pulseaudio -k #Reset pulseaudio
   exit 1
fi

#Get App source id
sourceId=$(
pactl list sink-inputs |
awk -v pid=$pid '
$1 == "Sink"  && $2 == "Input" {idx = $3}
$1 == "application.process.id" && $3 == "\"" pid "\"" {print idx; exit}' |
sed -e 's/#//')

if [[ -z $sourceId ]] ; then
    echo "Source id not found"
    pulseaudio -k
    exit 1
fi

#Get output sink id
outputId=$(
pactl list sinks |
awk -v outputNum=$outputNum '
$1 == "Sink"  {id = $2}
$1 == "Owner" && $3 == outputNum {print id; exit}' |
sed -e 's/#//')

if [[ -z $outputId ]] ; then
    echo "Output id not found"
    pulseaudio -k
    exit 1
fi

#Change the app output to the output sink
pactl move-sink-input ${sourceId} ${outputId}

#Bind to the virtual mic if we have one
if [[ -n $2 ]] ; then
  if [[ $2 =~ $numberExpr ]] ; then
    ./connectToMic.sh $outputId $2
  else
    echo "Virtual mic needs to be a number (pulseaudio ID), please rebind
      using correct ID"
    exit 1
  fi
fi 

echo $outputId
