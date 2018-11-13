#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/bbox-wechat-web ];then
            mkdir -p $installPath/bbox-wechat-web
        fi
rm -rf $installPath/bbox-wechat-web/*		
cp -r $parentBasePath/package/bbox-wechat-web.zip $installPath/bbox-wechat-web
sleep 7
 unzip $installPath/bbox-wechat-web/bbox-wechat-web.zip -d $installPath/bbox-wechat-web >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/bbox-wechat-web
 
