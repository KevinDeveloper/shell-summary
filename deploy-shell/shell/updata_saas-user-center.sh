#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentBasePath=$( cd $basePath/.. && pwd )
LOG_PATH=$(cat $parentBasePath/docker.conf | grep "LOG1_PATH1" | awk -F '=' '{print $2}')
installPath=/usr/local

 if [ ! -d $installPath/saas-user-center ];then
            mkdir -p $installPath/saas-user-center
        fi
rm -rf $installPath/saas-user-center/*		
cp -r $parentBasePath/package/saas-user-center.zip $installPath/saas-user-center
sleep 7
 unzip $installPath/saas-user-center/saas-user-center -d $installPath/saas-user-center >>/dev/null
 
 sleep 2
 chmod -R 755 $installPath/saas-user-center
 
