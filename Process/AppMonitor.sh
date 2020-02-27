#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppMonitor - monitors the resources used by the 6 C scripts


process=$(egrep "APM$1")

# individual process cpu and memory usage
memory=$(echo $apm_list | awk '{print $3}')
cpu=$(echo $apm_list | awk '{print $4}')

echo $memory,$cpu
