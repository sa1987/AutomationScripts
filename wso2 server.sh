#!/bin/bash
setenforce 0
sed -i 's/enforcing/disabled/g' /etc/selinux/config
systemctl disable firewalld
systemctl stop firewalld
systemctl status firewalld
iptables -L
iptables -F
systtemctl disable  iptables
systemctl disable  iptables
export http_proxy=proxy-ams-1.cisco.com:80
export https_proxy=proxy-ams-1.cisco.com:80
source  ~/.bashrc
echo http_proxy=proxy-ams-1.cisco.com:80 >/etc/environment
echo https_proxy=proxy-ams-1.cisco.com:80 >>/etc/environment
cd /tmp/
wget http://10.127.193.128/assurend/wso2is-5.3.0.zip --no-proxy
yum install java-1.7.0-openjdk.x86_64 java-1.7.0-openjdk-devel.x86_64 -y
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-1.7.0.141-2.6.10.1.el7_3.x86_64
echo "export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-1.7.0.141-2.6.10.1.el7_3.x86_64" >> /root/.bashrc
echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> /root/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-1.7.0.141-2.6.10.1.el7_3.x86_64" >> ~/.bashrc
echo "export PATH=${JAVA_HOME}/bin:${PATH}" >> ~/.bashrc
source ~/.bashrc
source /root/.bashrc
yum install unzip -y
unzip /tmp/wso2is-5.3.0.zip -d /opt/
cd /etc/init.d/
wget http://10.127.193.128/assurend/wso2server.sh --no-proxy
chmod 777 wso2server.sh



 #authconfig --enableldap --enableldapauth  --ldapserver=<>  --ldapbasedn="dc=<>,dc=<>"  --enablemkhomedir  --update 