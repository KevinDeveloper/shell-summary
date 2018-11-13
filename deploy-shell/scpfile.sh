#!/bin/sh

basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="$basePath/opnext.conf"
IPS=$(cat $ENV_FILE | grep "install_ips" | awk -F '=' '{print $2}')
IPARR=(${IPS//,/ })

ipAddr=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
chmod -R 755 $basePath

executScpFile(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start execute scpfile.sh file ..." 
    for ip in ${IPARR[@]}
	do
	    result=$(echo $ipAddr | grep "${ip}")
		if [ -n "$result" ];then
		    echo `date +'%Y-%m-%d %H:%M:%S'`": local compture not scp file ..."
			
		else
			echo `date +'%Y-%m-%d %H:%M:%S'`": Start SSH SCP File ..."
			ssh root@$ip "mkdir -p $basePath"
			
			scp -r $basePath/* root@$ip:$basePath
			
			sleep  10
			
			echo `date +'%Y-%m-%d %H:%M:%S'`": Start chmod 755 $ip:$basePath ..."
			ssh root@$ip "chmod -R 755 $basePath"
			
			echo `date +'%Y-%m-%d %H:%M:%S'`": Ended chmod 755 $ip:$basePath"
			ssh root@$ip "sh $basePath/docker.sh"
			echo `date +'%Y-%m-%d %H:%M:%S'`": reload docker.sh  file ..."
		fi  
	done
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended execute scpfile.sh file ..." 
}

#Main Function
executScpFile