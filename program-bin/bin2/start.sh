#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ENV_FILE="$DIR/setenv.sh"
if [ ! -f "$ENV_FILE" ]; then
    echo "No evn file to set"
else
    . "$ENV_FILE"
    jps | grep $SPRING_APPLICATION_NAME | awk '{system("kill -9 "$1)}'

    SPRING_PROFILES_ACTIVE=$SPRING_PROFILES_ACTIVE
    SPRING_APPLICATION_NAME=$SPRING_APPLICATION_NAME \
    APP_PATH="$APP_PATH" \
    APP_HOME="$APP_HOME" \
    APP_CONF_PATH="$APP_CONF_PATH" \
    nohup java $JAVA_OPTS $JAVA_JMX -jar  -Dspring.profiles.active=$SPRING_PROFILES_ACTIVE  $(find ${APP_HOME}/${SPRING_APPLICATION_NAME}  -name  ${SPRING_APPLICATION_NAME}*.jar) &
fi
