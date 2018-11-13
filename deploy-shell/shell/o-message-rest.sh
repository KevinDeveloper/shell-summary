#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp o-message-rest file .."
	cp -r $parentBasePath/apps/o-message-rest $installPath
    cp $parentBasePath/package/o-message-rest*.jar $installPath/o-message-rest
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp o-message-rest file .."
}

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create o-message-rest container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name o-message-rest --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/o-message-rest:/usr/local/o-message-rest  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/o-message-rest/bin/start.sh
   sleep 2
   
   docker start o-message-rest
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create o-message-rest container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep o-message-rest |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/o-message-rest

        fi
}

#Main function
updataContainer

installLocalService
createContainer
