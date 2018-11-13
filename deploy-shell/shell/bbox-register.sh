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


createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create bbox-register container of docker .."
   # --env-file 加载环境变量 第一个 -v 挂载jar 第二个-v挂载日志
   docker create --name bbox-register --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/bbox-register:/usr/local/bbox-register  -v $LOG_PATH:/var/log java8:v1  sh -c "/usr/local/bbox-register/chinese_env.sh && /usr/local/bbox-register/bin/start.sh"
   sleep 2
   
   docker start bbox-register
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create bbox-register container of docker .."
}

updataContainer(){
        docker_Container=`docker ps -a |grep bbox-register |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/bbox-register

        fi
}

#Main function
updataContainer
installLocalService
sleep  2
createContainer

