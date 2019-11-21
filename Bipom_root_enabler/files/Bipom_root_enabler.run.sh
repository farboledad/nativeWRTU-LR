#!/bin/sh

#Replacing old dropbear init script
cp /rom/mnt/cust/etc/init.d/dropbear /etc/init.d/dropbear

CHECKPERIOD=10
TIMEOUT=5 #6*10 = 6 Seconds without an active session. (actually 6-1)
DEFIDLETIMEOUT=300
COUNTER=0
ENABLED=0
OLDACTIVE=0

killall telnetd

while true; do

	# start telnet to get root access for development
	[ -z "`pidof telnetd`" ] && telnetd -l /bin/sh -p1234

	if [ -f "/tmp/root_access" ] ; then
		local idletimeout=$(cat /tmp/root_access)
		echo "$timeout"
		if [ "$ENABLED" -eq 0 ] ; then
			ENABLED=1
			echo "Enabling Root access"
			if expr "$idletimeout" : '[0-9]*$'>/dev/null; then
				if [ \( "$idletimeout" -le 0 \) -o \( "$idletimeout" -gt 3600 \) ] ; then
					idletimeout=$DEFIDLETIMEOUT
	                        fi 
			else
				idletimeout=$DEFIDLETIMEOUT
			fi
			echo "Idle Timeout: $idletimeout"
			uci set dropbear.default.IdleTimeout=$idletimeout
			uci commit dropbear
			echo "Stopping all running SSH sessions"
			killall dropbear
			/etc/init.d/dropbear start
			/rom/mnt/cust/bin/bipom_root_enabler 1
		else
			local active=$(ps|pgrep dropbear|wc -l)
			if [ "$active" -gt 1 ] ; then
				COUNTER=0
				OLDACTIVE=$active
			elif [ \( "$active" -eq 1 \) -a \( "$OLDACTIVE" -gt 1 \) ] ; then
				echo "SSH sessions are deactivated"
				OLDACTIVE=$active
				rm /tmp/root_access
			else
				#No active sessions after enabling root
				COUNTER=$((COUNTER+1))
				if [ "$COUNTER" -eq "$TIMEOUT" ] ; then
					echo "TIMEOUT: No active sessions"
					COUNTER=0
					rm /tmp/root_access
				fi
			fi
		fi
	else
		if [ "$ENABLED" -eq 1 ] ; then
			echo "Disabling Root access"			
			ENABLED=0
			/rom/mnt/cust/bin/bipom_root_enabler 0
			uci set dropbear.default.IdleTimeout=0
			uci commit dropbear
			/etc/init.d/dropbear restart
		fi
	fi
	sleep $CHECKPERIOD
done
