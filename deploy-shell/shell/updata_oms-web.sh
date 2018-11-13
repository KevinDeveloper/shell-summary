#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/oms-web ];then
            mkdir -p $installPath/oms-web
        fi
rm -rf $installPath/oms-web/*		
cp -r $parentBasePath/package/oms-web.zip $installPath/oms-web
sleep 7
 unzip $installPath/oms-web/oms-web.zip -d $installPath/oms-web >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/oms-web
 
