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

createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create visitor-wechat container of docker .."
   docker create --name visitor-wechat --env-file $parentBasePath/docker.conf --env LANG=zh_CN.UTF-8  --net host -v /etc/localtime:/etc/localtime:ro -v $installPath/visitor-wechat:/usr/local/visitor-wechat  -v $LOG_PATH:/var/log java8:v1 sh /usr/local/visitor-wechat/bin/start.sh 

   sleep 2
   
   docker start visitor-wechat
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create visitor-wechat container of docker .."
}


updataContainer(){
        docker_Container=`docker ps -a |grep visitor-wechat |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/visitor-wechat

        fi
}
#Main function
updataContainer
installLocalService
createContainer

