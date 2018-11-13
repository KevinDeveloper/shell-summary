#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp o-algorithm file .."
	cp -r $parentBasePath/apps/o-algorithm $installPath
    cp $parentBasePath/package/algo-rest*.jar $installPath/o-algorithm
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp o-algorithm file .."
}


createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create o-algorithm container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
docker create --name o-algorithm --restart=always --env-file $parentBasePath/docker.conf  --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/o-algorithm:/usr/local/o-algorithm  -v $LOG_PATH:/var/log algo-native:6.7 sh /usr/local/o-algorithm/bin/start.sh   sleep 2
   
   docker start o-algorithm
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create o-algorithm container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep o-algorithm |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/algo-rest

        fi
}

#Main function
updataContainer
installLocalService
createContainer
