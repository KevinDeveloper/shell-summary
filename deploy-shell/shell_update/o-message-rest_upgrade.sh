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

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start o-message-rest container of docker .."
   docker start o-message-rest
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded o-message-rest container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep o-message-rest |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/o-message-rest

        fi
}

#Main function
updataContainer
installLocalService
docker_start
