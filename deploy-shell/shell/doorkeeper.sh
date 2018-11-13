#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp doorkeeper file .."
	cp -r $parentBasePath/apps/doorkeeper $installPath
    cp $parentBasePath/package/doorkeeper*.jar $installPath/doorkeeper
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp doorkeeper file .."
}


createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create doorkeeper container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name doorkeeper --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/doorkeeper:/usr/local/doorkeeper -v $LOG_PATH:/var/log  java8:v1 sh /usr/local/doorkeeper/bin/start.sh
   sleep 2
   
   docker start doorkeeper
   echo `date +'%Y-%m-%d %H:%M:%S'`": Ended create doorkeeper container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep doorkeeper |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
			docker rm -f $docker_Container
			rm -rf $installPath/doorkeeper

	fi
}

#Main function
updataContainer
installLocalService
createContainer

