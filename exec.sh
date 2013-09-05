#!/bin/bash
clear
echo "
##########################################
#					 					#
#		PORT SCAN AUDITOR	 			#
#				Thong Ngo - UNS.VN		#
##########################################
...On progress"
ROOT="/home/thongngo/portscan"
DATE=$(date +%Y-%m-%d)
sh $ROOT/portscan.sh $ROOT/listip > $ROOT/logs/$DATE
cp $ROOT/logs/$DATE /var/www/portscan/logs/$DATE
php $ROOT/phpmailer/sendmail.php
echo "...DONE!!!"



