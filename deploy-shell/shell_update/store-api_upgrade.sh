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


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start start store-api container of docker .."
   docker start store-api
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded start store-api container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep store-api |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/store-api

        fi
}

#Main function
updataContainer
installLocalService
docker_start
