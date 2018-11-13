#!/env/sh
BASEPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $BASEPATH/.. && pwd )
ENV_FILE="$parentBasePath/docker.conf"

NTPSERVER=$(cat $ENV_FILE | grep "BB_NTP_HOST" | awk -F '=' '{print $2}')

settingsHostTimeZone(){
	echo "****************setting time zone:/Asia/Shanghai**********************"
	ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
}

installNTPDateService(){
    echo "********************isntall ntp date beginning**********************"
	rpm -i ${parentBasePath}/software/ntp/autogen-libopts-5.18-5.el7.x86_64.rpm --force
	sleep 2
	rpm -i ${parentBasePath}/software/ntp/ntpdate-4.2.6p5-19.el7.centos.x86_64.rpm  --force
	echo "********************isntall ntp date endding**********************"
}

loadConfigTimingSchedule(){
	echo "*****************settings crontab start*****************"
	echo "*/5 * * * *  /usr/sbin/ntpdate ${NTPSERVER}; /sbin/hwclock -w" >>/var/spool/cron/root
	echo "*****************settings crontab end *****************"
	systemctl  restart crond.service
}

#main function install ntp server
settingsHostTimeZone

loadConfigTimingSchedule
sleep 2
installNTPDateService
