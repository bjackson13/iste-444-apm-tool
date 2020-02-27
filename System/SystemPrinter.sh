#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# SystemPrinter - prints results sent by the System monitor to a csv file
# Also controls timing and the loop for system monitoring

# catch function - removes temp file
remove_temp () {
	rm -f temp.txt
}

trap remove_temp EXIT

# ip passed in as first arg
ip=$1

# make the log file
touch system_metrics.csv

# run the loop until told not to
while true
do
	# run the system monitor commands in the background to avoid delays caused by the 1 second sample in ifstat
	# errors are ignored
	./System/SystemMonitor.sh $ip > temp.txt 2> /dev/null &
	
	# sleep for 5 seconds
	sleep 5
	
	# print the script runtime and the system monitor results to the log file
	echo "$SECONDS,$(<temp.txt)" >> system_metrics.csv 

done
