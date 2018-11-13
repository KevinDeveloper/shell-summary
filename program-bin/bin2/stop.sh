#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="$DIR/setenv.sh"

if [ ! -f "$ENV_FILE" ]; then
    echo "No evn file to set"
else
    . "$ENV_FILE"
    jps | grep $SPRING_APPLICATION_NAME | awk '{system("kill -9 "$1)}'
fi
