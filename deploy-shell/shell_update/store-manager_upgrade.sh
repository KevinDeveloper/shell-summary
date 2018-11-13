#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp store-manager file .."
	cp -r $parentBasePath/apps/store-manager $installPath
    cp $parentBasePath/package/store-manager*.jar $installPath/store-manager
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp store-manager file .."
}


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start store-manager container of docker .."
   docker start store-manager
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded store-manager container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep store-manager |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/store-manager

        fi
}

#Main function

updataContainer
installLocalService
docker_start
