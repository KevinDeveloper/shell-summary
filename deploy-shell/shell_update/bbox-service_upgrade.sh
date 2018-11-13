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

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start bbox-service container of docker .."
   docker start bbox-service
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded bbox-service container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep bbox-service |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/bbox-service

        fi
}

#Main function

updataContainer
installLocalService
docker_start

