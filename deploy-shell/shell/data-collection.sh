#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp data-collection file .."
	cp -r $parentBasePath/apps/data-collection $installPath
    cp $parentBasePath/package/data-collection*.jar $installPath/data-collection
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp data-collection file .."
}

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create data-collection container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name data-collection --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/data-collection:/usr/local/data-collection  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/data-collection/bin/start.sh
   sleep 2
   
   docker start data-collection
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create data-collection container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep data-collection |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/data-collection

        fi
}

#Main function
updataContainer
installLocalService
createContainer

