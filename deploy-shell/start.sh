#!/bin/bash

StartDocker(){
	echo `date +'%Y-%m-%d %H:%M:%S'`": Start docker images .."
	/usr/bin/docker ps -a|grep -v 'NAMES'|awk '{print $NF}'|xargs docker start
	echo `date +'%Y-%m-%d %H:%M:%S'`": Ended docker images .."
}
StartDocker
