#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp bbox-batch file .."
	cp -r $parentBasePath/apps/bbox-batch $installPath

    cp $parentBasePath/package/bbox-batch*.jar $installPath/bbox-batch
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp bbox-batch file .."
}

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start bbox-batch container of docker .."
   docker start bbox-batch
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded bbox-batch container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep bbox-batch |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/bbox-batch

        fi
}

#Main function
updataContainer
installLocalService
docker_start
