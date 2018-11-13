#!/bin/sh

#IPS=$(cat $ENV_FILE | grep "install_ips" | awk -F '=' '{print $2}')
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
chown -R root:root $basePath
chmod -R 755 $basePath

sedip(){
        echo date +'%Y-%m-%d %H:%M:%S'": sed opnext.conf and docker.conf"
        ${basePath}/base.sh
}
sedip

ENV_FILE="$basePath/opnext.conf"
IPS=$(cat $ENV_FILE | grep "install_ips" | awk -F '=' '{print $2}')
IPARR=(${IPS//,/ })

createSSHKeys(){
    echo  date +'%Y-%m-%d %H:%M:%S'": execute ssh keygen"
    ssh-keygen -t rsa
    echo  date +'%Y-%m-%d %H:%M:%S'": execute ssh keygen ..."
}
sshCopyId(){
    for ip in ${IPARR[@]}
    do
         echo  date +'%Y-%m-%d %H:%M:%S'": $ip"
         ssh-copy-id $ip
	 echo "scp filehander_add.sh to $ip"
	 ssh root@${ip} "mkdir ${basePath}"
	 scp ${basePath}/filehander_add.sh root@${ip}:${basePath}
	 ssh root@${ip} "chmod -R 755 ${basePath}"
	 sleep 1
	 echo "sh filehander_add close selinux update limit"
	 ssh root@${ip} "${basePath}/filehander_add.sh"
    done
}
createSSHKeys
sleep 2
sshCopyId
