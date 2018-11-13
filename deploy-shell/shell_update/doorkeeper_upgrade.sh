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


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start doorkeeper container of docker .."
   docker start doorkeeper
   echo `date +'%Y-%m-%d %H:%M:%S'`": Ended doorkeeper container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep doorkeeper |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
			docker stop $docker_Container
			rm -rf $installPath/doorkeeper

	fi
}

#Main function
updataContainer
installLocalService
docker_start

