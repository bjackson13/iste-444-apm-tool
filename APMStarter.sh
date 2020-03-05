#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# APMStarter - Starts the app monitoring tool

# Get IP address from args
ip=$1

# remove all old csv files
rm -f *.csv 2> /dev/null

# Start the 6 C scripts
start_c_scripts () {
	for i in {1..6}
	do
		./Scripts/APM$i $ip &
	done
}

# start the monitor scripts
start_printer_scripts () {
	# start the process monitor
	./Process/AppPrinter.sh &

	# start the system monitor
	./System/SystemPrinter.sh $ip &
	
	echo Montoring started...
}

# Exit trap function - kills c scripts and monitor scripts
cleanup () {
	
	# kill the system monitor/printer
	systemid=$( ps -e | egrep "SystemPrinter" | awk '{print $1}' )
	kill -15 $systemid 1> /dev/null 2> /dev/null
	echo System monitoring killed.	

	# kill the process monitor/printer
	processid=$( ps -e | egrep "AppPrinter" | awk '{print $1}' )
	kill -15 -p $processid 1> /dev/null 2> /dev/null
	echo App monitoring killed.	

	# kill the APM c scripts
	for i in {1..6}
	do
		pid=$( ps -e | egrep "APM$i" | awk '{print $1}' )
		kill -15 $pid 2> /dev/null
	done

	echo Test Scripts killed.
}

# trap for exit - call cleanup   
trap 'cleanup' EXIT

# call our functions to start the APM tool
start_c_scripts
start_printer_scripts
wait
echo Script and monitoring stopped...
