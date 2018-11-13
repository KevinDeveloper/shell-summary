#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/bbox-visitor-web ];then
            mkdir -p $installPath/bbox-visitor-web
        fi
rm -rf $installPath/bbox-visitor-web/*		
cp -r $parentBasePath/package/bbox-visitor-web.zip $installPath/bbox-visitor-web
sleep 7
 unzip $installPath/bbox-visitor-web/bbox-visitor-web.zip -d $installPath/bbox-visitor-web >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/bbox-visitor-web
 
