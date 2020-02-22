#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# SystemMonitor - monitors system resource usage

# IP address passed to script
ip=$1

# Get the network interface card based on the ip address passed in
nic=$( ifconfig | grep -B 1 "$ip" | awk -F: 'NR==1 {print $1}' )

while true
do
	#TODO:Ask about Timing - ifstat has built in delay, around 135s it adds on extra second - clarify against document as well

	# get network utilizatio with sample after 1 second
	bandwidth=$( ifstat -i $nic 5 1 | awk 'NR>2 {print $1" "$2}' )	
	rx=$( echo $bandwidth | cut -d " " -f 1 )
	tx=$( echo $bandwidth | cut -d " " -f 2 )
	
	# Get the disk writes in kB/s
	diskwrites=$( iostat -d sda | grep sda | awk '{print $4}' )
       	
	
	# Get disk utilization for '/' mount in MB
	diskutil=$( df -BM / | awk 'NR==2{print $4}' | egrep -o [0-9] | tr -d "\n" )

	echo "$SECONDS, $rx, $tx, $diskwrites, $diskutil"
done

