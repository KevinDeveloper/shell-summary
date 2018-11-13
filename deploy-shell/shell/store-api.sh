#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local


installLocalService(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp store-api file .."
	cp -r $parentBasePath/apps/store-api $installPath
    cp $parentBasePath/package/store-api*.jar $installPath/store-api
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp store-api file .."
}


createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create store-api container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name store-api --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/store-api:/usr/local/store-api  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/store-api/bin/start.sh
   sleep 2
   
   docker start store-api
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create store-api container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep store-api |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/store-api

        fi
}

#Main function

updataContainer
installLocalService
createContainer
