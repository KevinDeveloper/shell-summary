#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="$basePath/opnext.conf"

ip_algroithm=$(cat $ENV_FILE | grep "ip_algroithm" | awk -F '=' '{print $2}')
ip_bbox_batch=$(cat $ENV_FILE | grep "ip_bbox_batch" | awk -F '=' '{print $2}')
ip_bbox_register=$(cat $ENV_FILE | grep "ip_bbox_register" | awk -F '=' '{print $2}')
ip_bbox_service=$(cat $ENV_FILE | grep "ip_bbox_service" | awk -F '=' '{print $2}')
ip_bbox_visitor=$(cat $ENV_FILE | grep "ip_bbox_visitor" | awk -F '=' '{print $2}')
ip_data_collection=$(cat $ENV_FILE | grep "ip_data_collection" | awk -F '=' '{print $2}')
ip_gateway=$(cat $ENV_FILE | grep "ip_gateway" | awk -F '=' '{print $2}')

ip_wechat=$(cat $ENV_FILE | grep "ip_bbox_wechat" | awk -F '=' '{print $2}')

ip_oauth=$(cat $ENV_FILE | grep "ip_oauth" | awk -F '=' '{print $2}')
ip_ocfs_server=$(cat $ENV_FILE | grep "ip_ocfs_server" | awk -F '=' '{print $2}')
ip_message=$(cat $ENV_FILE | grep "ip_message" | awk -F '=' '{print $2}')
ip_ostream=$(cat $ENV_FILE | grep "ip_ostream" | awk -F '=' '{print $2}')
ip_user_center=$(cat $ENV_FILE | grep "ip_user_center" | awk -F '=' '{print $2}')
ip_store_api=$(cat $ENV_FILE | grep "ip_store_api" | awk -F '=' '{print $2}')
ip_store_manager=$(cat $ENV_FILE | grep "ip_store_manager" | awk -F '=' '{print $2}')
ip_push_server=$(cat $ENV_FILE | grep "ip_push_server" | awk -F '=' '{print $2}')

ip_ntp=$(cat $ENV_FILE | grep "ip_ntp" | awk -F '=' '{print $2}')
ip_ntpdate=$(cat $ENV_FILE | grep "ip_ntpdate" | awk -F '=' '{print $2}')

ip_mongo=$(cat $ENV_FILE | grep "ip_mongo" | awk -F '=' '{print $2}')
ip_mysql=$(cat $ENV_FILE | grep "ip_mysql" | awk -F '=' '{print $2}')
ip_redis=$(cat $ENV_FILE | grep "ip_redis" | awk -F '=' '{print $2}')
ip_fastdfs=$(cat $ENV_FILE | grep "ip_fastdfs" | awk -F '=' '{print $2}')
ip_rabbitmq=$(cat $ENV_FILE | grep "ip_rabbitmq" | awk -F '=' '{print $2}')
ip_nginx=$(cat $ENV_FILE | grep "ip_nginx" | awk -F '=' '{print $2}')
ip_consul=$(cat $ENV_FILE | grep "ip_consul" | awk -F '=' '{print $2}')
ip_frp=$(cat $ENV_FILE | grep "ip_frp" | awk -F '=' '{print $2}')
ipAddr=$(ip addr | awk '/^[0-9]+: / {}; /inet.*global/ {print gensub(/(.*)\/(.*)/, "\\1", "g", $2)}')
IPARR=(${ip_ntpdate//,/ })
echo `date +'%Y-%m-%d %H:%M:%S'`": This is app.sh ..."

installConsul(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": This is consul method..."
	if [ -n "$ip_consul" ]; then  
		result=$(echo $ipAddr | grep "${ip_consul}")
		echo `date +'%Y-%m-%d %H:%M:%S'`": result: $result ..."
		if [ -n "$result" ];then
			sh ${basePath}/shell/consul.sh
		else
			echo `date +'%Y-%m-%d %H:%M:%S'`": This is consul : $ip_consul ..."
		    ssh root@$ip_consul "sh ${basePath}/shell/consul.sh"
									
		fi
	fi
}

installAlgroithm(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": This is installAlgroithm method..."
	if [ -n "$ip_algroithm" ]; then  
		result=$(echo $ipAddr | grep "${ip_algroithm}")
		echo `date +'%Y-%m-%d %H:%M:%S'`": result: $result ..."
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/algorithm-service_upgrade.sh
		else
			echo `date +'%Y-%m-%d %H:%M:%S'`": This is $ip_algroithm ..."
		    ssh root@$ip_algroithm "sh ${basePath}/shell_update/algorithm-service_upgrade.sh"
									
		fi
	fi
}

installBBoxBatch(){
    if [ -n "$ip_bbox_batch" ]; then
	    result=$(echo $ipAddr | grep "${ip_bbox_batch}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/bbox-batch_upgrade.sh
		else
		    ssh root@$ip_bbox_batch "sh $basePath/shell_update/bbox-batch_upgrade.sh"
									
		fi
	fi
}

installBBoxRegister(){
    if [ -n "$ip_bbox_register" ]; then
	    result=$(echo $ipAddr | grep "${ip_bbox_register}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/bbox-register_upgrade.sh
		else
		    ssh root@$ip_bbox_register "sh $basePath/shell_update/bbox-register_upgrade.sh"
									

		fi
	fi
}

installBBoxWechat(){
    if [ -n "$ip_wechat" ]; then
            result=$(echo $ipAddr | grep "${ip_wechat}")
                if [ -n "$result" ];then
                        sh ${basePath}/shell_update/visitor-wechat_upgrade.sh
                else
                    ssh root@$ip_wechat "sh $basePath/shell_update/visitor-wechat_upgrade.sh"


                fi
        fi
}


installBBoxService(){
	if [ -n "$ip_bbox_service" ]; then 
		result=$(echo $ipAddr | grep "${ip_bbox_service}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/bbox-service_upgrade.sh
		else
		    ssh root@$ip_bbox_service "sh ${basePath}/shell_update/bbox-service_upgrade.sh"
									
		fi
	fi
}

installBBoxVisitor(){
	if [ -n "$ip_bbox_visitor" ]; then   
		result=$(echo $ipAddr | grep "${ip_bbox_visitor}")
		if [ -n "$result" ];then
			 sh ${basePath}/shell_update/visitor-manager_upgrade.sh
		else
		    ssh root@$ip_bbox_visitor " sh ${basePath}/shell_update/visitor-manager_upgrade.sh"
									
		fi
	fi
}
installDataCollection(){
	if [ -n "$ip_data_collection" ]; then   
		result=$(echo $ipAddr | grep "${ip_data_collection}")
		if [ -n "$result" ];then
			 sh ${basePath}/shell/data-collection.sh
		else
		    ssh root@$ip_data_collection " sh ${basePath}/shell/data-collection.sh"
									
		fi
	fi
}

installGateway(){
	if [ -n "$ip_gateway" ]; then 
		result=$(echo $ipAddr | grep "${ip_gateway}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/doorkeeper_upgrade.sh
		else
		    ssh root@$ip_gateway "sh ${basePath}/shell_update/doorkeeper_upgrade.sh"
									
		fi
	fi
}

installOauth(){
	if [ -n "$ip_oauth" ]; then  
		result=$(echo $ipAddr | grep "${ip_oauth}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/kaioh-api_upgrade.sh
		else
		    ssh root@$ip_oauth "sh ${basePath}/shell_update/kaioh-api_upgrade.sh"
									
		fi
	fi
}

installOcfsServer(){
	if [ -n "$ip_ocfs_server" ]; then 
		result=$(echo $ipAddr | grep "${ip_ocfs_server}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/ocfs-server_upgrade.sh
		else
		    ssh root@$ip_ocfs_server "sh ${basePath}/shell_update/ocfs-server_upgrade.sh"
									
		fi
	fi
}

installMessage(){
	if [ -n "$ip_message" ]; then
		result=$(echo $ipAddr | grep "${ip_message}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/o-message-rest_upgrade.sh
		else
		    ssh root@$ip_message "sh ${basePath}/shell_update/o-message-rest_upgrade.sh"
									
		fi
	fi
}

installOstream(){
	if [ -n "$ip_ostream" ]; then
		result=$(echo $ipAddr | grep "${ip_ostream}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/o-stream_upgrade.sh
		else
		    ssh root@$ip_ostream "sh ${basePath}/shell_update/o-stream_upgrade.sh"
									
		fi
	fi
}

installUserCenter(){
	if [ -n "$ip_user_center" ]; then   
		result=$(echo $ipAddr | grep "${ip_user_center}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/user-center_upgrade.sh
		else
		    ssh root@$ip_user_center "sh ${basePath}/shell_update/user-center_upgrade.sh"
									
		fi
	fi
}

installStoreApi(){
	if [ -n "$ip_store_api" ]; then   
		result=$(echo $ipAddr | grep "${ip_store_api}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/store-api_upgrade.sh
		else
		    ssh root@$ip_store_api "sh ${basePath}/shell_update/store-api_upgrade.sh"
									
		fi
	fi
}

installStoreManager(){
	if [ -n "$ip_store_manager" ]; then   
		result=$(echo $ipAddr | grep "${ip_store_manager}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/store-manager_upgrade.sh
		else
		    ssh root@$ip_store_manager "sh ${basePath}/shell_update/store-manager_upgrade.sh"
									
		fi
	fi
}

installPushServer(){
        if [ -n "$ip_push_server" ]; then
                result=$(echo $ipAddr | grep "${ip_push_server}")
                if [ -n "$result" ];then
                        sh ${basePath}/shell_update/push-server_upgrade.sh
                else
                    ssh root@$ip_push_server "sh ${basePath}/shell_update/push-server_upgrade.sh"

                fi
        fi
}

installNtp(){
    if [ -n "$ip_ntp" ]; then
	    result=$(echo $ipAddr | grep "${ip_ntp}")
		if [ -n "$result" ];then
			sh ${basePath}/shell/ntp.sh
		fi
		
	fi	
}
installNtpdate(){
    for ntpdateIp in ${IPARR[@]}
	do
	    ssh root@$ntpdateIp "sh $basePath/shell/ntpdate.sh"						
	done
}
installNginx(){
	if [ -n "$ip_nginx" ]; then
	    result=$(echo $ipAddr | grep "${ip_nginx}")
		if [ -n "$result" ];then
			sh ${basePath}/shell_update/nginx-upgrade.sh
		else
		    ssh root@$ip_nginx "sh ${basePath}/shell/nginx-upgrade.sh"
									
		fi
	fi
}

installMongoDB(){
    if [ -n "$ip_mongo" ]; then	    
		result=$(echo $ipAddr | grep "${ip_mongo}")
		if [ -n "$result" ];then
			sh ${basePath}/shell/mongo.sh
		else
		    ssh root@$ip_mongo "sh ${basePath}/shell/mongo.sh"
									
		fi
	fi
}
installMySQL(){
    if [ -n "$ip_mysql" ]; then	    
		result=$(echo $ipAddr | grep "${ip_mysql}")
		if [ -n "$result" ];then
			sh ${basePath}/shell/mysql.sh
		else
		    ssh root@$ip_mysql "sh ${basePath}/shell/mysql.sh"
									
		fi
	fi
}
installRabbitMQ(){
    if [ -n "$ip_rabbitmq" ]; then	    
		result=$(echo $ipAddr | grep "${ip_rabbitmq}")
		if [ -n "$result" ];then
			sh ${basePath}/shell/rabbitmq.sh
		else
		    ssh root@$ip_rabbitmq "sh ${basePath}/shell/rabbitmq.sh"
									
		fi
	fi
}
installRedis(){
    if [ -n "$ip_redis" ]; then	    
		result=$(echo $ipAddr | grep "${ip_redis}")
		if [ -n "$result" ];then
			sh ${basePath}/shell/redis.sh
		else
		    ssh root@$ip_redis "sh ${basePath}/shell/redis.sh"
									
		fi
	fi
}
installFastDFS(){
   if [ -n "$ip_fastdfs" ]; then	    
		result=$(echo $ipAddr | grep "${ip_fastdfs}")
		if [ -n "$result" ];then
		    sh ${basePath}/shell/fastdfs.sh
		else
		    ssh root@$ip_fastdfs "sh ${basePath}/shell/fastdfs.sh"
									
		fi
	fi
}




installFrp(){
   if [ -n "$ip_frp" ]; then
                result=$(echo $ipAddr | grep "${ip_frp}")
                if [ -n "$result" ];then
                    sh ${basePath}/frp_client_install/install_frp_global.sh
                else
                    ssh root@$ip_fastdfs "sh ${basePath}/frp_client_install/install_frp_global.sh"

                fi
   else
	echo "ip_frp is null ,do not install frpc service."
   fi
}

#main function
#installMongoDB
#installMySQL
#installRabbitMQ
#installRedis
#installFastDFS

#installConsul
#installNginx
#installNtp
#installNtpdate


installOauth
installOcfsServer
installMessage
installOstream
installBBoxBatch
installBBoxRegister
installBBoxService
installBBoxVisitor
#installDataCollection
installBBoxWechat
installUserCenter
installStoreApi
installStoreManager
installPushServer
installAlgroithm
sleep 5
installGateway
#installFrp
