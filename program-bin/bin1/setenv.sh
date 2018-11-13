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

## private
## Don't Modify this section.
APP_PATH="$APP_HOME/$SPRING_APPLICATION_NAME"
APP_CONF_PATH="$APP_HOME/$SPRING_APPLICATION_NAME/$SPRING_APPLICATION_CONF"
