#!/bin/sh

# CG9101-nanoWiPOM

sleep 30

#killall telnetd

while true; do
	# start wrtusrv
	[ -z "`pidof wipom-srv`" ] && /rom/mnt/cust/bin/wipom-srv & 

	# start telnet to get root access
#	[ -z "`pidof telnetd`" ] && telnetd -l /bin/sh -p1234 

	sleep 5
done
