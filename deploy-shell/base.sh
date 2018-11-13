#!/bin/bash

basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="${basePath}/opnext.conf"
DOC_FILE="${basePath}/docker.conf"
ACL_FILE="${basePath}/software/consul/acl_config.json"
App_ip=$(cat $ENV_FILE | grep "IP_app="|awk -F '=' '{print $2}')
Db_ip=$(cat $ENV_FILE | grep "IP_db="|awk -F '=' '{print $2}')

if [ ${App_ip} == ${Db_ip} ];
then
	echo "app and db install to one host"
	echo  date +'%Y-%m-%d %H:%M:%S'":start update opnext.conf"
	sed -i "s/install_ips=ip_db,ip_app/install_ips=ip_app/g" ${ENV_FILE}
	sleep 2
	sed -i "s/ip_app/${App_ip}/g" ${ENV_FILE}
	sed -i "s/ip_db/${Db_ip}/g" ${ENV_FILE}
	echo  date +'%Y-%m-%d %H:%M:%S'":start update docker.conf"
	sed -i "s/ip_app/${App_ip}/g" ${DOC_FILE}
	sed -i "s/ip_db/${Db_ip}/g" ${DOC_FILE}
	echo date +'%Y-%m-%d %H:%M:%S'":End update docker.conf"
    echo date +'%Y-%m-%d %H:%M:%S'":start update acl_config"
    sed -i "s/ip_app/${App_ip}/g" ${ACL_FILE}
    echo date +'%Y-%m-%d %H:%M:%S'":stop update acl_config"
else
	echo "app and db not in ont host"
	echo  date +'%Y-%m-%d %H:%M:%S'":start update opnext.conf"
	sed -i "s/ip_app/${App_ip}/g" ${ENV_FILE}
	sed -i "s/ip_db/${Db_ip}/g" ${ENV_FILE}
	echo  date +'%Y-%m-%d %H:%M:%S'":start update docker.conf"
	sed -i "s/ip_app/${App_ip}/g" ${DOC_FILE}
	sed -i "s/ip_db/${Db_ip}/g" ${DOC_FILE}
	echo date +'%Y-%m-%d %H:%M:%S'":End update docker.conf"
    echo date +'%Y-%m-%d %H:%M:%S'":start update acl_config"
    sed -i "s/ip_app/${App_ip}/g" ${ACL_FILE}
    echo date +'%Y-%m-%d %H:%M:%S'":stop update acl_config"
fi