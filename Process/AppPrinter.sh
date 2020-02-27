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
		results=$(./Process/AppMonitor.sh $i)

		echo "$SECONDS,$results" >> ./APM"$i"_metrics.csv
	done
	sleep 5
done
