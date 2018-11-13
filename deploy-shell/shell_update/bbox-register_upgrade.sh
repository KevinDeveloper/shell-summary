#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp bbox-register file .."
	cp -r $parentBasePath/apps/bbox-register $installPath
    cp $parentBasePath/package/bbox-register*.jar $installPath/bbox-register
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp bbox-register file .."
}


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start bbox-register container of docker .."
   docker start bbox-register
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded bbox-register container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep bbox-register |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/bbox-register

        fi
}

#Main function
updataContainer
installLocalService
sleep  2
docker_start

