#!/env/sh

BASEPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $BASEPATH/.. && pwd )

INSTALLPATH=/usr/local/ServiceMonitoring


settingsHostTimeZone(){
	echo "****************setting time zone:/Asia/Shanghai**********************"
	ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
}

installNTPService(){
    echo "********************isntall ntp server beginning**********************"
	rpm -i ${parentBasePath}/software/ntp/autogen-libopts-5.18-5.el7.x86_64.rpm --force
	sleep 2
	rpm -i ${parentBasePath}/software/ntp/ntpdate-4.2.6p5-19.el7.centos.x86_64.rpm  --force
	sleep 2
	rpm -i ${parentBasePath}/software/ntp/ntp-4.2.6p5-19.el7.centos.x86_64.rpm  --force
	echo "********************isntall ntp server endding**********************"
}

mkdirInstallPath(){
	echo "*****************mkdir ${INSTALLPATH}*****************"
	mkdir -p ${INSTALLPATH}
}
copyServiceMonitroShell(){
	echo "*****************run ${INSTALLPATH} start*****************"
	cp -r ${BASEPATH}/ntpmonitoring.sh  ${INSTALLPATH}
	echo "*****************run ${INSTALLPATH} end  *****************"
}

#settings crontab ：Run a script every five minutes.
runningServiceMontitor(){
	echo "*****************settings crontab start*****************"
	echo "*/5 * * * * . /etc/profile;/bin/sh ${INSTALLPATH}/ntpmonitoring.sh" >>/var/spool/cron/root

	echo "*****************settings crontab end *****************"
	systemctl restart crond.service
}

settingNTPConfig(){
	echo "****************setting ntpd service conf file **********************"
	if [ -f /etc/ntp.conf ];then
	    mv /etc/ntp.conf /etc/ntp.conf_bak
	fi
	cp -r ${parentBasePath}/conf/ntp.conf /etc/
	systemctl start ntpd.service
	systemctl disable chronyd.service
	systemctl enable ntpd.service
	
	sleep 1
	#iptables -I INPUT -p udp --dport 123 -j ACCEPT -m comment --comment "NTP Service"
	#iptables-save > /etc/sysconfig/iptables
	firewall-cmd --zone=public --add-port=123/udp --permanent &>> ntp.log
	firewall-cmd --reload &>> ntp.log
	echo "****************setting ntpd service conf file **********************"

	#main funcation
	if [ ! -d ${INSTALLPATH} ]; then
		mkdirInstallPath
	fi
	copyServiceMonitroShell
	runningServiceMontitor
}

#main function install ntp server
settingsHostTimeZone
sleep 1
installNTPService
sleep 2
settingNTPConfig
