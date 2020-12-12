#!/bin/bash
wget 10.127.193.128/assurend/jdk-8u141-linux-x64.rpm --no-proxy
yum -y localinstall jdk-8u141-linux-x64.rpm
export JAVA_HOME=/usr/java/jdk1.8.0_141/
export JRE_HOME=/usr/java/jdk1.8.0_141/jre
source ~/.bash_profile
yum install unzip -y
groupadd tomcat
useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
cd ~
psql -U reportserver -d reportserver -a -f /opt/tomcat/webapps/ROOT/ddl/reportserver-RS3.0.2-5855-schema-PostgreSQL_CREATE.sql
wget 10.127.193.128/assurend/apache-tomcat-8.5.20.tar.gz
wget 10.127.193.128/assurend/reportserver.zip
mkdir /opt/tomcat
tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
chown -R tomcat:tomcat /opt/tomcat
rm -rf /opt/tomcat/webapps/ROOT/*
unzip reportserver.zip -d /opt/tomcat/webapps/ROOT/
cp /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties.example /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties

cat << EOF >> /opt/tomcat/webapps/ROOT/WEB-INF/classes/persistence.properties

hibernate.connection.username=reportserver
hibernate.connection.password=redhat
hibernate.dialect=net.datenwerke.rs.utils.hibernate.PostgreSQLDialect
hibernate.connection.driver_class=org.postgresql.Driver
hibernate.connection.url=jdbc:postgresql://localhost/reportserver
EOF


chown -R tomcat:tomcat /opt/tomcat/webapps/ROOT/

cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JRE_HOME=/usr/java/jdk1.8.0_141/jre
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='JAVA_OPTS="-Djava.awt.headless=true -Xmx2g  -XX:+UseConcMarkSweepGC -Dfile.encoding=UTF8 -Drs.configdir=/opt/reportserver"'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF



yum -y install postgresql-server postgresql-contrib unzip
postgresql-setup initdb
systemctl start postgresql
systemctl enable postgresql
cd /tmp/
sudo -u postgres createdb reportserver
sudo -u postgres bash -c "psql -c \"CREATE USER reportserver WITH PASSWORD 'redhat';\""
sudo -u postgres bash -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE reportserver TO reportserver;\""
cp /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf_bak
sed -i 's/peer/trust/g' /var/lib/pgsql/data/pg_hba.conf
sed -i 's/ident/md5/g' /var/lib/pgsql/data/pg_hba.conf
systemctl restart postgresql
systemctl status postgresql
psql -U reportserver -d reportserver -a -f /opt/tomcat/webapps/ROOT/ddl/reportserver-RS3.0.2-5855-schema-PostgreSQL_CREATE.sql


systemctl start tomcat
systemctl enable tomcat
systemctl status tomcat
