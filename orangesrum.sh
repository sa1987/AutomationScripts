#!/bin/bash
yum install epel-release -y
yum install httpd -y
sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/"  /etc/httpd/conf/httpd.conf
sed -i 's/^/#&/g' /etc/httpd/conf.d/welcome.conf

systemctl start httpd.service
systemctl enable httpd.service
wget 10.127.193.128/<userName>/sugarcrm/MariaDB.repo --no-proxy
mv MariaDB.repo /etc/yum.repos.d/
yum install MariaDB-server MariaDB-client -y

cat << EOF >> /etc/my.cnf

[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
init_connect='SET collation_connection=utf8_unicode_ci'
init_connect='SET NAMES utf8'
character-set-server=utf8
collation-server=utf8_unicode_ci
skip-character-set-client-handshake
EOF


systemctl start mariadb.service
systemctl enable mariadb.service
pwd=redhat
yum install expect -y

expect -f - <<-EOF
  set timeout 10
  spawn mysql_secure_installation
  expect "Enter current password for root (enter for none):"
  send -- "\r"
  expect "Set root password?"
  send -- "y\r"
  expect "New password:"
  send -- "${pwd}\r"
  expect "Re-enter new password:"
  send -- "${pwd}\r"
  expect "Remove anonymous users?"
  send -- "y\r"
  expect "Disallow root login remotely?"
  send -- "n\r"
  expect "Remove test database and access to it?"
  send -- "y\r"
  expect "Reload privilege tables now?"
  send -- "y\r"
  expect eof
EOF

cd
wget 10.127.193.128/<userName>/orangescrum/ius-release.rpm --no-proxy
rpm -Uvh ius-release.rpm
yum install php56u php56u-mysqlnd php56u-gd php56u-imap php56u-ldap php56u-odbc php56u-xml php56u-xmlrpc php56u-mbstring php56u-mcrypt php56u-mssql php56u-snmp php56u-soap php56u-tidy php56u-pear curl libcurl-devel -y
cp /etc/php.ini /etc/php.ini.bak
sed -i "s/post_max_size = 8M/post_max_size = 200M/" /etc/php.ini
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 200M/" /etc/php.ini
systemctl restart httpd.service
systemctl status httpd.service
cd
wget 10.127.193.128/<userName>/orangescrum/v1.6.1.tar.gz --no-proxy
tar -zxvf v1.6.1.tar.gz
mv ~/orangescrum-1.6.1 /var/www/html && sudo chown root:root -R /var/www/html
chmod -R 0777 /var/www/html/orangescrum-1.6.1/{app/Config,app/tmp,app/webroot}
cat << EOF >> /etc/httpd/conf.d/orangescrum.conf

<VirtualHost *:80>
ServerName localhost
DocumentRoot /var/www/html/orangescrum-1.6.1
<Directory /var/www/html/orangescrum-1.6.1>
Options Indexes FollowSymLinks MultiViews
AllowOverride All
Order allow,deny
allow from all
</Directory>
</VirtualHost>
EOF

mysql -uroot -predhat -e "create database orangescrum;"
mysql -uroot -predhat -e "grant all privileges on orangescrum.* to ''@'%'  identified by 'redhat';"
mysql -uroot -predhat -e " flush privileges;"

mysql -u root -predhat orangescrum < /var/www/html/orangescrum-1.6.1/database.sql 
cd
wget 10.127.193.128/<userName>/orangescrum/database.php --no-proxy
mv -f database.php /var/www/html/orangescrum-1.6.1/app/Config/database.php
 chmod 777 /var/www/html/orangescrum-1.6.1/app/webroot/
 chmod 777 /var/www/html/orangescrum-1.6.1/app/tmp/
systemctl restart httpd.service
systemctl status httpd.service

