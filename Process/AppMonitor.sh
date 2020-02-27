#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppMonitor - monitors the resources used by the 6 C scripts

process=$(ps -e | egrep "APM$1" | awk '{print $1}') 

process_metrics=$(ps -p $process -o %cpu,%mem)

# individual process cpu and memory usage
memory=$(echo $process_metrics | awk '{print $3}')
cpu=$(echo $process_metrics | awk '{print $4}')

echo $memory,$cpu
