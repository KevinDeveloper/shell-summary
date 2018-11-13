## required
## Your APP's parent dir, not your APP's dir
APP_HOME=/home/apps
## Your runtime env, see resource/application-xxx.yml
SPRING_PROFILES_ACTIVE=qa
## Your App Name
SPRING_APPLICATION_NAME=bbox-batch
SPRING_APPLICATION_CONF=conf
## optional
## for JDK arguments set in here
JAVA_OPTS="-Xms2048m -Xmx2048m"
JAVA_JMX="-Djava.rmi.server.hostname=172.16.20.30 -Dcom.sun.management.jmxremote.port=18084 -Dcom.sun.management.jmxremote=true -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.tools.visualvm.modules.visualgc.originalUI=true"

## private
## Don't Modify this section.
APP_PATH="$APP_HOME/$SPRING_APPLICATION_NAME"
APP_CONF_PATH="$APP_HOME/$SPRING_APPLICATION_NAME/$SPRING_APPLICATION_CONF"
