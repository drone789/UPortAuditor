#!/bin/bash
clear
if [ ! -f $1 ]; then
	echo "File $1 Not Found <= IP/Host per line"
	exit
fi

ROOT="/home/thongngo/portscan"
DATE=$(date +%Y-%m-%d)
#echo "
########################################################
#	      	   PORT SCAN AUDITOR		       #
########################################################
\r\n"

mv $ROOT/today/* $ROOT/lasttime/
STT=0
COUNTCHANGE=0
for ip in $(cat $1 )
do
	STT=$((STT+1))
	nmap --open -F $ip > $ROOT/tmp
	cat  $ROOT/tmp | grep open > $ROOT/today/$ip
	if [ ! -f $ROOT/lasttime/$ip ]; then 
		echo "--------------------------------------------------------"
		echo "$ip: First scan"
		cat $ROOT/tmp
		# Summary Diff Scan
		echo $ip >> $ROOT/SUMDIFF
		# Count
		COUNTCHANGE=$((COUNTCHANGE+1))
		continue 
	fi
	diff $ROOT/lasttime/$ip $ROOT/today/$ip > $ROOT/alldiff/$ip
		
	DIFF=$(cat $ROOT/alldiff/$ip | wc -l )
	echo "--------------------------------------------------------"
	if [ $DIFF -gt 1 ]; then
		echo "$ip got some change:"
		cat $ROOT/alldiff/$ip
		echo "\r\n_Last scan:"
		cat $ROOT/lasttime/$ip
		echo "\r\n_Today:"
		cat $ROOT/today/$ip
		echo "\r\n"
		# Summary Diff Scan
		echo $ip >> $ROOT/SUMDIFF
		# Count
		COUNTCHANGE=$((COUNTCHANGE+1))
		
	else 
		echo "$ip: No Change \r\n"
	fi
done

# Echo amount to bottom of file
echo $COUNTCHANGE >> $ROOT/SUMDIFF
echo "--------------------------------------------------------"
echo " 		 Scan task complete: $STT IP"
echo "--------------------------------------------------------"

