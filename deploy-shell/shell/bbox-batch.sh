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

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create bbox-batch container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name bbox-batch --env-file $parentBasePath/docker.conf --env LANG=zh_CN.utf8 --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/bbox-batch:/usr/local/bbox-batch  -v $LOG_PATH:/var/log  java8:v1 sh -c "/usr/local/bbox-batch/chinese_env.sh && /usr/local/bbox-batch/bin/start.sh"
   sleep 2
   
   docker start bbox-batch
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create bbox-batch container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep bbox-batch |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/bbox-batch

        fi
}

#Main function
updataContainer
installLocalService
createContainer
