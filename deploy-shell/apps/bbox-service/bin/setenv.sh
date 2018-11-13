APP_HOME=/usr/local
## Your runtime env, see resource/application-xxx.yml
SPRING_PROFILES_ACTIVE=prod
## Your App Name
SPRING_APPLICATION_NAME=bbox-service

#APP_PATH="$APP_HOME/$SPRING_APPLICATION_NAME"
LOG_PATH="$APP_PATH/$SPRING_APPLICATION_NAME/logs"

# default jvm args
# --------------------------------------------------------------
JVM_ARGS="-server -Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8 -Djava.io.tmpdir=/tmp -Djava.net.preferIPv6Addresses=false"

JVM_GC="-XX:+DisableExplicitGC -XX:+PrintGCDetails -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+UseConcMarkSweepGC -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"
JVM_GC=$JVM_GC" -XX:CMSFullGCsBeforeCompaction=0 -XX:+UseCMSCompactAtFullCollection -XX:CMSInitiatingOccupancyFraction=80"
JVM_HEAP="-XX:SurvivorRatio=8 -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=128m -XX:+HeapDumpOnOutOfMemoryError -XX:ReservedCodeCacheSize=128m -XX:InitialCodeCacheSize=128m"
JVM_SIZE="-Xmx1g -Xms128m"

JMX_PORT="50004"
JMX_HOSTNAME="-Djava.rmi.server.hostname=${BB_LOCAL_HOST_IP}"
JMX_ARGS="-Dcom.sun.management.jmxremote $JMX_HOSTNAME  -Dcom.sun.management.jmxremote.port=$JMX_PORT -Dcom.sun.management.jmxremote.rmi.port=$JMX_PORT -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"

JAVA_OPTION=" $JVM_ARGS $JVM_SIZE $JVM_HEAP $JVM_JIT $JVM_GC $JMX_ARGS"
JAVA_OPTION=" $JAVA_OPTION -Xloggc:$LOG_PATH/$SPRING_APPLICATION_NAME.gc.log -XX:ErrorFile=$LOG_PATH/$SPRING_APPLICATION_NAME.vmerr.log -XX:HeapDumpPath=$LOG_PATH/$SPRING_APPLICATION_NAME.heaperr.log "

APP_JAR=$(find ${APP_HOME}/${SPRING_APPLICATION_NAME}  -name  *.jar)
