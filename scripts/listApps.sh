#!/bin/bash

#creates the null sink for the app as well as the loopback connection
#Usage: ./listApps.sh
#Outputs: 
# name 
# PID
# ...

pactl list sink-inputs |
awk '
$1 == "application.name" {print $3}
$1 == "application.process.id" {print $3}'|
sed -e 's/\"//g'
