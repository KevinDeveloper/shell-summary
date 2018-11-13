#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/opnext-web ];then
            mkdir -p $installPath/opnext-web
        fi
rm -rf $installPath/opnext-web/*		
cp -r $parentBasePath/package/opnext-web.zip $installPath/opnext-web
sleep 7
 unzip $installPath/opnext-web/opnext-web.zip -d $installPath/opnext-web >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/opnext-web
 
