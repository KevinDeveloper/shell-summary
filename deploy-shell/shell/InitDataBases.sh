#!/bin/sh
parentBasePath=/home

executeSql(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": excute mysql database sql shell"
	USERNAME=root
    	ROOTPASSWORD=123456
	store=${parentBasePath}/store.sql
	doorkeeper=${parentBasePath}/door-keeper.sql
	oservice=${parentBasePath}/o-service.sql
	usercenter=${parentBasePath}/user-center.sql
        visitorjob=${parentBasePath}/visitor-job.sql
        bpush=${parentBasePath}/bpush.sql

	store_db=store
	doorkeeper_db=door-keeper
	oservice_db=o-service
	usercenter_db=user-center
	visitorjob_db=visitor-job
	bpush_db=bpush

	user_create="CREATE USER IF NOT EXISTS '${BB_MYSQL_USERNAME}'@'%' IDENTIFIED BY '$BB_MYSQL_PASSWORD'"

	grant_db="GRANT ALL ON *.* TO '$BB_MYSQL_USERNAME'@'%' IDENTIFIED BY '$BB_MYSQL_PASSWORD' WITH GRANT OPTION"
    sleep 1
	echo "***********start create db/table/data********"
	
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${store_db}\` DEFAULT CHARACTER SET utf8;"
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${doorkeeper_db}\` DEFAULT CHARACTER SET utf8;"
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${oservice_db}\` DEFAULT CHARACTER SET utf8;"
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${usercenter_db}\` DEFAULT CHARACTER SET utf8;"
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${visitorjob_db}\` DEFAULT CHARACTER SET utf8;"
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${bpush_db}\` DEFAULT CHARACTER SET utf8;"
	
	mysql -u${USERNAME} -p${ROOTPASSWORD} ${store_db} -e "source ${store}"
	sleep 1
	mysql -u${USERNAME} -p${ROOTPASSWORD} ${doorkeeper_db} -e "source ${doorkeeper}"
	sleep 1
	mysql -u${USERNAME} -p${ROOTPASSWORD} ${oservice_db} -e "source ${oservice}"
	sleep 1
	mysql -u${USERNAME} -p${ROOTPASSWORD} ${usercenter_db} -e "source ${usercenter}"
    sleep 2
    mysql -u${USERNAME} -p${ROOTPASSWORD} ${visitorjob_db} -e "source ${visitorjob}"
    sleep 2
    mysql -u${USERNAME} -p${ROOTPASSWORD} ${bpush_db} -e "source ${bpush}"


        sleep 4
	echo "Endding create int data"

	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "${user_create}" 2>/dev/null

	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "${grant_db}" 2>/dev/null
	mysql -u${USERNAME} -p${ROOTPASSWORD} -e "flush privileges" 2>/dev/null

	echo "**********end create saas_admin and saas_tenant db/table/data***********"

}
#Main function
executeSql


