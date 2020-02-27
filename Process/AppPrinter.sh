#! /bin/bash
# ISTE-444 Project 1
# Josh Schrader
# Abbey Sands
# Brennan Jackson
# AppPrinter - prints results sent by the app monitor to a csv file


# gets list of all processes
process_list=$(echo ps aux)
apm_list=$($process_list | egrep APM[0-9])

for i in {1..6}
do
./AppMonitor ${i}> temp.txt 2> /dev/null &

echo "$SECONDS,$(<temp.txt)" >> ./APM${i}_metrics.csv

#delay script 5 seconds
sleep 5
done
