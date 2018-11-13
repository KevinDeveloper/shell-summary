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

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create visitor-manager container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name visitor-manager --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/visitor-manager:/usr/local/visitor-manager  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/visitor-manager/bin/start.sh
   sleep 2
   
   docker start visitor-manager
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create visitor-manager container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep visitor-manager |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/visitor-manager

        fi
}

#Main function

updataContainer
installLocalService
createContainer

