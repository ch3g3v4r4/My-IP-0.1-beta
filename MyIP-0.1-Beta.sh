#!/bin/bash

#Wellcome

echo "|||Welcome to MyIP-TOOL 0.1 Beta|||"

#Initial run:

if 

	! wget http://ipinfo.io/ip -qO - ; then
	notify-send --expire-time=15000 "Public access not available" 
	echo  "$(date) Public access not available"  >> myip.log

else
	INITIAL_RUN_PUBLIC=$(wget http://ipinfo.io/ip -qO -)
	INITIAL_RUN_PRIVATE=$(ifconfig | grep 192.168.* -B1 | cut -d " " -f1,12-100)
	ifconfig | grep 192.168.* -B1 | cut -d " " -f1,12-100
	notify-send --expire-time=15000 "IP status report:" "

Your public IP is:
$INITIAL_RUN_PUBLIC

Your private IP is:
$INITIAL_RUN_PRIVATE"

fi

#Add entry to log:

echo "$(date) IP status report:" "
Your public IP is:$INITIAL_RUN_PUBLIC

Your private IP is:$INITIAL_RUN_PRIVATE" >> myip.log 
echo "$(date) Starting check loop" >> myip.log

#Public and local IP check loop:

while true ;
do

FIRST_RUN_PUBLIC=$(wget http://ipinfo.io/ip -qO -)
FIRST_RUN_PRIVATE=$(ifconfig | grep 192.168.* -B1 | cut -d " " -f1,12-100)

sleep 30

	if ! wget http://ipinfo.io/ip -qO -; then
	notify-send --expire-time=10000 "Public access not available"
	echo "Public access not available"
	echo "$(date) Public access not available" >> myip.log


else

SECOND_RUN_PUBLIC=$(wget http://ipinfo.io/ip -qO -)
SECOND_RUN_PRIVATE=$(ifconfig | grep 192.168.* -B1 | cut -d " " -f1,12-100)
echo "$SECOND_RUN_PRIVATE"

fi

#Desktop notifications:

if 
[ "$FIRST_RUN_PUBLIC" == "$SECOND_RUN_PUBLIC" ] && [ "$FIRST_RUN_PRIVATE" == "$SECOND_RUN_PRIVATE" ]  ;then
echo "Check complete,Public IP unchanged
Check complete,Private IP unchanged"
echo "Starting new run"
echo "$(date) Check complete,Public IP unchanged
Check complete,Private IP unchanged" >> myip.log
echo "$(date) Starting new run" >> myip.log
else
notify-send --expire-time=15000 "IP status report:" "Your public IP is:
$SECOND_RUN_PUBLIC
Your private IP is:
$SECOND_RUN_PRIVATE"
fi

#Add entry to log:

echo "$(date) IP status report:" "
Your public IP is:
$SECOND_RUN_PUBLIC

Your private IP is:
$SECOND_RUN_PRIVATE">> myip.log 

done


#Author:ch3g3v4r4
#PLEASE REPORT ALL BUGS AND ERRORS!THX!
