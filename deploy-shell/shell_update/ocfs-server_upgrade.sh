#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp kaioh-api file .."
	cp -r $parentBasePath/apps/ocfs-api $installPath
    cp $parentBasePath/package/ocfs-api*.jar $installPath/ocfs-api
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp kaioh-api file .."
}

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start  ocfs-api container of docker .." 
   docker start ocfs-api
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded  ocfs-api container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep ocfs-api |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/ocfs-api

        fi
}

#Main function
updataContainer
installLocalService
docker_start