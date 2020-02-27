#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# APMStarter - Starts the app monitoring tool

# Get IP address from args
ip=$1

# Start the 6 C scripts
start_c_scripts () {
	for i in {1..6}
	do
		./Scripts/APM$i $ip &
	done
}

start_system_scripts () {
	# start all the system scripts
	#./Scripts/bandwidth_hog_burst.c &
	#./Scripts/cpu_hog.c &
	#./Scripts/bandwidth_hog.c &
	#./Scripts/disk_hog.c &
	#./Scripts/memory_hog.c &
	#./Scripts/memory_hog_leak.c &
	echo
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
	kill -5 $systemid 1> /dev/null 2> /dev/null
	echo System monitoring killed.	

	# kill the process monitor/printer
	processid=$( ps -e | egrep "AppPrinter" | awk '{print $1}' )
	kill -5 -p $processid 1> /dev/null 2> /dev/null
	echo App monitoring killed.	

	# kill the APM c scripts
	for i in {1..6}
	do
		pid=$( ps -e | egrep "APM$i" | awk '{print $1}' )
		kill $pid 2> /dev/null
	done

	# kill all of the system scripts
	#bwhogburstpid=$( ps -e | egrep "bandwidth_hog_burst" | awk '{print $1}' )
	#kill $bwhogburstpid 2> /dev/null
	#bwhog=$( ps -e | egrep "cpu_hog" | awk '{print $1}' )
	#kill $bwhog 2> /dev/null
	#cpuhog=$( ps -e | egrep "bandwidth_hog" | awk '{print $1}' )
	#kill $cpuhog 2> /dev/null
	#diskhog=$( ps -e | egrep "disk_hog" | awk '{print $1}' )
	#kill $diskhog 2> /dev/null
	#memhog=$( ps -e | egrep "memory_hog" | awk '{print $1}' )
	#kill $memhog 2> /dev/null
	#memleak=$( ps -e | egrep "memory_hog_leak" | awk '{print $1}' )
	#kill $memleak 2> /dev/null

	echo Test Scripts killed.
}

# trap for exit - call cleanup   
trap 'cleanup' EXIT

# call our functions to start the APM tool
start_c_scripts
start_system_scripts
start_printer_scripts
wait
echo Script and monitoring stopped...
