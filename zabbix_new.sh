
#!/bin/bash
hn=$1
sqlpwd=$2

hostnamectl set-hostname $hn

echo "# MariaDB 10.1 CentOS repository list - created 2016-12-09 03:50 UTC" >> /etc/yum.repos.d/MariaDB.repo
echo "# http://downloads.mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/MariaDB.repo
echo "[mariadb]" >> /etc/yum.repos.d/MariaDB.repo
echo "name = MariaDB" >> /etc/yum.repos.d/MariaDB.repo
echo "baseurl = http://yum.mariadb.org/10.1/centos7-amd64" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/MariaDB.repo
echo "gpgcheck=1" >> /etc/yum.repos.d/MariaDB.repo

yum install MariaDB-server MariaDB-client -y
yum install httpd. httpd-devel. -y
systemctl start httpd
systemctl enable httpd
yum install php. php-cli. php-common. php-devel. php-pear. php-gd. php-mbstring. php-mysql. php-xml. php-bcmath. -y 

systemctl start mariadb
systemctl enable mariadb
mysqladmin -u root password $sqlpwd
 yum -y install http://repo.zabbix.com/zabbix/3.2/rhel/7//zabbix-release-3.2-1.el7.noarch.rpm 
yum -y install zabbix-get. zabbix-server-mysql. zabbix-web-mysql. zabbix-agent.                                                                                                                                                          
echo "php_value date.timezone Asia/Kolkata" >> /etc/httpd/conf.d/zabbix.conf
service httpd restart
mysql -uroot -p$sqlpwd -e "CREATE DATABASE zabbixdb CHARACTER SET UTF8;"
mysql -uroot -p$sqlpwd -e "GRANT ALL PRIVILEGES on zabbixdb.* to zabbix@localhos                                                                                                                                                             
mysql -uroot -p$sqlpwd -e "FLUSH PRIVILEGES;"
cd /usr/share/doc/zabbix-server-mysql*
gunzip *.gz
mysql -u zabbix -ppassword123 zabbixdb < create.sql
#mysql -u zabbix -ppassword123 zabbixdb < schema.sql
#mysql -u zabbix -ppassword123 zabbixdb < images.sql
#mysql -u zabbix -ppassword123 zabbixdb < data.sql
 service zabbix-server start
 systemctl enable zabbix-server 
 systemctl restart httpd 