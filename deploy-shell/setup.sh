#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
chmod -R 755 $basePath

installDocker(){
   echo `date +'%Y-%m-%d %H:%M:%S'`": reload docker.sh  file ..."
   sh $basePath/docker.sh
   
}

installApps(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": execute apps.sh file ..."
	sh $basePath/apps.sh
}

scpPackage(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": execute scpfile.sh file ..."
    sh $basePath/scpfile.sh
}

#Main Function
installDocker
sleep 5
scpPackage
sleep 10
installApps

echo "*****  GO TO SAAS WEB WITH :  Enjoy Beeboxes SaaS!!! "