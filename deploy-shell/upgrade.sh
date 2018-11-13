#!/bin/sh
basePath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

installApps(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": execute apps.sh file ..."
	sh $basePath/app_upgrade.sh
}

scpPackage(){
    echo `date +'%Y-%m-%d %H:%M:%S'`": execute scpfile.sh file ..."
    sh $basePath/scpfile.sh
}

#Main Function
#installDocker
sleep 5
scpPackage
sleep 10
installApps
