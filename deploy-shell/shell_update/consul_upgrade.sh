#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
installPath=/usr/local

installLocalService(){
   
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp algorithm-service file .."
	if [ ! -d $installPath/consul ];then
	    cp -r $parentBasePath/software/consul  $installPath/
		chmod 755  $installPath/consul
	fi
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp algorithm-service file .."
}


docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start bbox-batch container of docker .."
   docker start consul
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded bbox-batch container of docker .."
}
 
updataContainer(){
        docker_Container=`docker ps -a |grep consul |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/bbox-batch

        fi
}

#Main function
updataContainer
installLocalService
createContainer
