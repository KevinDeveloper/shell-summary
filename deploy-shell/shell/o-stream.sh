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


createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create o-stream container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name o-stream --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/o-stream:/usr/local/o-stream  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/o-stream/bin/start.sh
   sleep 2
   
   docker start o-stream
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create o-stream container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep o-stream |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/o-stream

        fi
}

#Main function
updataContainer
installLocalService
createContainer
