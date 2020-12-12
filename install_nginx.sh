#!/bin/bash

yum install epel-release -y
yum clean all &&  yum update -y 
cd
curl --silent --location https://rpm.nodesource.com/setup_6.x |  bash -
yum install -y nodejs
yum install git -y
cd /opt
git clone https://github.com/sdelements/lets-chat.git
cd lets-chat
npm install
cp settings.yml.sample settings.yml
npm install forever -g
cd /opt/lets-chat
forever start app.js