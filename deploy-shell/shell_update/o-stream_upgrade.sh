#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp o-stream file .."
	cp -r $parentBasePath/apps/o-stream $installPath
    cp $parentBasePath/package/o-stream*.jar $installPath/o-stream
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp o-stream file .."
}


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start o-stream container of docker .."
   docker start o-stream
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded o-stream container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep o-stream |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/o-stream

        fi
}

#Main function
updataContainer
installLocalService
docker_start
