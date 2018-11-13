#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

installLocalService(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp visitor-wechat file .."
	cp -r  $parentBasePath/apps/visitor-wechat $installPath
    cp $parentBasePath/package/visitor-wechat*.jar $installPath/visitor-wechat
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp visitor-wechat file .."
}

docker_start(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create visitor-wechat container of docker .."
   docker start visitor-wechat
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create visitor-wechat container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep visitor-wechat |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker stop $docker_Container
                        rm -rf $installPath/visitor-wechat

        fi
}
#Main function
updataContainer
installLocalService
docker_start

