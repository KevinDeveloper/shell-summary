#!/bin/sh

systemctl stop firewalld
/usr/sbin/setenforce 0

echo '* soft nofile 65536' >> /etc/security/limits.conf
echo   '* hard nofile 65536' >> /etc/security/limits.conf 
	
	



echo 'fs.file-max=655350' >> /etc/sysctl.conf



/sbin/sysctl -p

systemctl stop firewalld
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
