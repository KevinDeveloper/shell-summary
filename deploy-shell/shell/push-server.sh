#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp push-server file .."
	cp -r  $parentBasePath/apps/push-server $installPath
    cp $parentBasePath/package/push-server*.jar $installPath/push-server
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp push-server file .."
}

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create push-server container of docker .."
   docker create --name push-server --env-file $parentBasePath/docker.conf --env LANG=zh_CN.UTF-8  --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/push-server:/usr/local/push-server  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/push-server/bin/start.sh 

   sleep 2
   
   docker start push-server
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create push-server container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep push-server |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/push-server

        fi
}
#Main function
updataContainer
installLocalService
createContainer

