import os
import subprocess
subprocess.call('mkdir /opt/tomcat/ && cd /opt/tomcat', shell=True);
// installing tomcat server
subprocess.call('wget http://www.interior-dsgn.com/apache/tomcat/tomcat-8/v8.0.23/bin/apache-tomcat-8.0.23.zip ', shell=True);
subprocess.call('unzip apache-tomcat-8.0.23.zip', shell=True);
subprocess.call('cd apache-tomcat-8.0.23/bin', shell=True);
subprocess.call('chmod 700 /opt/tomcat/apache-tomcat-8.0.23/bin/*.sh', shell=True);
//starting the server
subprocess.call('bash /opt/tomcat/apache-tomcat-8.0.23/bin/startup.sh', shell=True);
subprocess.call('echo $HOME', shell=True);
subprocess.call('bash JAVA_HOME=/user/java/jdk1.5.0_06', shell=True);
subprocess.call('export JAVA_HOME',shell=True);
subprocess.call('tsh setenv JAVA_HOME /user/java/jdk1.5.0_06',shell=True);
subprocess.call('bash TOMCAT_HOME=/var/tomcat',shell=True);
subprocess.call('export TOMCAT_HOME',shell=True);
subprocess.call('tsh setenv TOMCAT_HOME /var/tomcat',shell=True);
//setting the port number to 80
subprocess.call('iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080', shell=True);
//installing the my sql server
subprocess.call('sudo apt-get install mysql-server',shell=true);
//setting the user password
subprocess.call('mysql -u root password 'welcome1', shell=True);
subprocess.call('mysql -V', shell=True);
//running the petclinic.sql file
subprocess.call('create database petclinic;',shell=True);
// Configuring the application with database.
subprocess.call('wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.40.zip', shell=True);
subprocess.call('unzip mysql-connector-java-5.1.40.zip', shell=True);
//deploying the application
current_path=os.getcwd();
subprocess.call('mv '+ current_path + '/petclinic.war  /opt/tomcat/webapps/petclinic.war',shell=True);
//starting the server
subprocess.call('bash /opt/tomcat/apache-tomcat-8.0.23/bin/shutdown.sh', shell=True);
subprocess.call('bash /opt/tomcat/apache-tomcat-8.0.23/bin/startup.sh', shell=True);
