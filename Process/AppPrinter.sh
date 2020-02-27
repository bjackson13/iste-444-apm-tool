#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppPrinter - prints results sent by the app monitor to a csv file

while true
do
	for i in {1..6}
	do
	./AppMonitor.sh $i > p_temp.txt 2> /dev/null

	echo "$SECONDS,$(<p_temp.txt)" >> ./APM${i}_metrics.csv

	#delay script 5 seconds
	done
	sleep 5
done
