#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG_PATH" | awk -F '=' '{print $2}')
DATA_PATH=$(cat $parentBasePath/docker.conf | grep "DATA_PATH" | awk -F '=' '{print $2}')
installPath=/usr/local


loadImageMirro(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": Start import fastdfs docker images..."
    docker load -i $parentBasePath/images/fastdfs-stand-alone.tar 
    echo `date +'%Y-%m-%d %H:%M:%S'`": Endded import fastdfs docker images..."
}

settingsConfig(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create fastdfs store filepath..."
   if [ ! -d /data/fastdfs/tracker ];then
       mkdir -p /data/fastdfs/tracker
   fi
   if [ ! -d /data/fastdfs/storage ];then
       mkdir -p /data/fastdfs/storage
   fi
   echo `date +'%Y-%m-%d %H:%M:%S'`": Ended create fastdfs store filepath..."
}
createContainer(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": Start create fastdfs container of docker .."
   docker create --name fastdfs-stand-alone -v $DATA_PATH/fastdfs:/data/fastdfs -v /etc/localtime:/etc/localtime:ro -v $LOG_PATH:/var/log/fastdfs --hostname tracker --net host fastdfs-stand-alone:v1 supervisord
   sleep 2
   
   docker start fastdfs-stand-alone
   echo `date +'%Y-%m-%d %H:%M:%S'`": Endded create fastdfs container of docker .."
}


#Main function
loadImageMirro
sleep  3
settingsConfig
createContainer

