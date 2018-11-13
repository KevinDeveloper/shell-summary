#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
installPath=/usr/local
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')

installLocalService(){
   
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start cp algorithm-service file .."
	cp -r $parentBasePath/apps/algorithm-service $installPath
	cp -r $parentBasePath/software/opzoon  $installPath/
	sleep 5
	chmod -R 755  $installPath/opzoon
	cp $parentBasePath/conf/algorithm.conf /etc/ld.so.conf.d
	chmod 755 /etc/ld.so.conf.d/algorithm.conf
    cp $parentBasePath/package/algorithm-service*.jar $installPath/algorithm-service
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended cp algorithm-service file .."
}

 
createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start install docker environment.."/
   docker create --name algorithm-service --env-file $parentBasePath/docker.conf --net host -v /etc/localtime:/etc/localtime:ro -v /lib64:/lib64 -v /etc/ld.so.conf:/etc/ld.so.conf -v /etc/ld.so.conf.d:/etc/ld.so.conf.d -v $installPath/algorithm-service:/usr/local/algorithm-service  -v $LOG_PATH:/var/log -v $installPath/opzoon:/usr/local/opzoon java8:v1 sh /usr/local/algorithm-service/bin/start.sh
   sleep 2
   
   docker start algorithm-service
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endding install docker environment.."
}

updataContainer(){
        docker_Container=`docker ps -a |grep algorithm-service |awk '{print $1}'`
        if [ -n "$docker_Container" ]; then
                        docker rm -f $docker_Container
                        rm -rf $installPath/algorithm-service

        fi
}

#Main function
updataContainer
installLocalService
createContainer
