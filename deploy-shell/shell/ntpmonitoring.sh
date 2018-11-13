#!/bin/sh
BASEPATH=/home/ntp
INSTALLPATH=/opt/opzoonface/ServiceMonitoring

chmod -R 755 ${INSTALLPATH}/*

runNtp(){
	echo "ntp is already installed!"
	countNtpd=`ps -ef|grep ntpd |grep -v grep|awk '{print $2}'`
        if [ -n "$countNtpd" ]; then
		echo "NTP  IS RUNNING"
	else
                echo "NTP is Not RUNNING, try to start it"
		systemctl restart ntpd.service
        fi
}


#Main Function
runNtp
