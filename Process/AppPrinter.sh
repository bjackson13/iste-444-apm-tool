#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppPrinter - prints results sent by the app monitor to a csv file

remove_temp () {
        rm -f p_temp.txt
}

trap remove_temp EXIT


while sleep 5
do
	for i in {1..6}
	do
	./Process/AppMonitor.sh $i > p_temp.txt 2> /dev/null

	echo "$SECONDS,$(<p_temp.txt)" >> ./APM"$i"_metrics.csv
	done
done
