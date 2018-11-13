#!/bin/sh
fromPath=/home/repository/backup
toPath=/home/repository
deploy_Path=/home/deploy-shell
#SCP_IPS=127.0.0.1
#IPS=(${SCP_IPS//,/ })
chmod -R 755 $fromPath
executeScpFile(){
  echo `date +'%Y-%m-%d %H:%M:%S'`": Start execute scpfile file ..."
  datename=$(date +%Y%m%d-%H:%M:%S)
#  JAR_ARRAY=(bbox-batch bbox-domain bbox-image bbox-register bbox-service bbox-sms bbox-support data-collection doorkeeper-gw doorkeeper-monitor doorkeeper-service kaioh-api kaioh-core kaioh-service o-message-client o-message-core o-message-rest ocfs-api ocfs-service push-core push-server push-service sso-client sso-core tribe-common tribe-consul user-api user-service visitor-manager visitor-support visitor-upload visitor-wechat algorithm-service o-stream manager api)
#  WEB_ARRAY=(bbox-visitor-web bbox-VSM opnext-web saas-user-center oms-web bbox-wechat-web)
JAR_ARRAY=(algorithm-service bbox-batch bbox-register bbox-service doorkeeper kaioh-api o-message-rest ocfs-api push-server store-api store-manager user-api visitor-manager visitor-wechat data-collection)
WEB_ARRAY=(web-saas web-saas web-store web-visitor-admin web-visitor-reception web-visitor-wechat web-wechat-sso)

# JAR_ARRAY=(${JAR_DIR//,/})
# WEB_ARRAY=(${WEB_DIST//,/})
 # for ip in ${IPS[@]}
#  do
      mv  ${toPath}/upgread ${toPath}/upgread_${datename}
      mkdir ${toPath}/upgread
      echo "Beginning copy  jar file to ${ip} host"
      for jar in ${JAR_ARRAY[@]}
      do
       #  scp  ${fromPath}/${jar}/target/*.jar  root@${ip}:$toPath/package
	 cp_name=`find ${fromPath} -name "${jar}*.jar"|tail -n 1|awk -F "/" '{print $NF}'`
         echo "cp  ${fromPath}/${cp_name} to toPath "
         cp  ${fromPath}/${jar}/${cp_name}  $toPath/upgread
      done
        # copy target/o-stream.jar
        # cp  ${fromPath}/target/*.jar  $toPath/package
      echo "copy jar file  end !"
      echo "Beginning copy dist file to ${ip} host"
      for dist in ${WEB_ARRAY[@]}
      do
	  cp_zip=`find ${fromPath} -name "${dist}*zip"|tail -n 1|awk -F "/" '{print $NF}'`
          cp  -r  ${fromPath}/$dist/${cp_zip}  $toPath/upgread
      done
      echo "cope file is   end !"
 # done
}

copy_package(){
	mv  ${deploy_Path}/package ${deploy_Path}/package_${datename}
	cp -r ${toPath}/upgread ${deploy_Path}/package
}
executeScpFile
sleep 3
copy_package