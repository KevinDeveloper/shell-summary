#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp user-api file .."
	cp -r $parentBasePath/apps/user-api $installPath
    cp $parentBasePath/package/user-api*.jar $installPath/user-api
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp user-api file .."
}

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create user-api container of docker .."/
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name user-api --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/user-api:/usr/local/user-api -v $LOG_PATH:/var/log java8:v1 sh /usr/local/user-api/bin/start.sh
   sleep 2
   
   docker start user-api
   echo `date +'%Y-%m-%d %H:%M:%S'`": Ended create user-api container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep user-api |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/user-api

        fi
}

#Main function

updataContainer
installLocalService
createContainer
