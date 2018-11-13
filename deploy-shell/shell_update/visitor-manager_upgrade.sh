#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp visitor-manager file .."
	cp -r  $parentBasePath/apps/visitor-manager $installPath
    cp $parentBasePath/package/visitor-manager*.jar $installPath/visitor-manager
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp visitor-manager file .."	
}

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start visitor-manager container of docker .."
   docker start visitor-manager
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded visitor-manager container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep visitor-manager |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/visitor-manager

        fi
}

#Main function

updataContainer
installLocalService
docker_start

