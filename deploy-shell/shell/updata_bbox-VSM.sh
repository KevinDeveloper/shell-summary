#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/bbox-VSM ];then
            mkdir -p $installPath/bbox-VSM
        fi
rm -rf $installPath/bbox-VSM/*		
cp -r $parentBasePath/package/bbox-VSM.zip $installPath/bbox-VSM
sleep 7
 unzip $installPath/bbox-VSM/bbox-VSM.zip -d $installPath/bbox-VSM >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/bbox-VSM
 
