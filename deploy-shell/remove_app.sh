#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="$basePath/opnext.conf"
IPS=$(cat $ENV_FILE | grep "install_ips" | awk -F '=' '{print $2}')
IPARR=(${IPS//,/ })
ipAddr=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')


removeapp(){
    for ip in ${IPARR[@]}
    do
         echo  date +'%Y-%m-%d %H:%M:%S'": $ip"
         result=$(echo $ipAddr | grep "${ip}")
         echo `date +'%Y-%m-%d %H:%M:%S'`": result: $result ..."
         if [ -n "$result" ];then
                sh ${basePath}/remove.sh
         else
                echo `date +'%Y-%m-%d %H:%M:%S'`": This is consul : $ip ..."
                ssh root@$ip "sh ${basePath}/remove.sh"

          fi
		 
    done
}


removeapp
