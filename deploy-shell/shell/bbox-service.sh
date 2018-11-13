#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp bbox-service file .."
	cp -r  $parentBasePath/apps/bbox-service $installPath
    cp $parentBasePath/package/bbox-service*.jar $installPath/bbox-service
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp bbox-service file .."
}

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create bbox-service container of docker .."
   docker create --name bbox-service --env-file $parentBasePath/docker.conf --env LANG=zh_CN.UTF-8  --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/bbox-service:/usr/local/bbox-service  -v $LOG_PATH:/var/log java8:v1 sh -c "/usr/local/bbox-service/chinese_env.sh && /usr/local/bbox-service/bin/start.sh" --security-opt seccomp:unconfined
   sleep 2
   
   docker start bbox-service
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create bbox-service container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep bbox-service |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/bbox-service

        fi
}

#Main function

updataContainer
installLocalService
createContainer

