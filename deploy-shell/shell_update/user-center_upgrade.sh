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

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start start user-api container of docker .."/
   docker start user-api
   echo `date +'%Y-%m-%d %H:%M:%S'`": Ended start user-api container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep user-api |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/user-api

        fi
}

#Main function

updataContainer
installLocalService
docker_start
