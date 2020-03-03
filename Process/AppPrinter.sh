#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppPrinter - prints results sent by the app monitor to a csv file

remove_temp () {
	rm -f temp*.txt
}

trap remove_temp EXIT

while true
do
	# sleep for 5 seconds in the background
	sleep 5 &
	for i in {1..6}
	do
		./Process/AppMonitor.sh $i > temp$i.txt 2> /dev/null &	

	done

	wait
	# set SECONDS to variable since the metrics were already received and we need to run the for loop still which skews the times
	seconds=$SECONDS
	# print once 5 seconds has passed
	for i in {1..6}
	do
		echo "$seconds,$(<temp$i.txt)" >> ./APM"$i"_metrics.csv
	done
	
done
