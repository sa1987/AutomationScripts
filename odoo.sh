#!/bin/bash
yum update
yum install -y epel-release
yum install postgresql-server
postgresql-setup initdb	
systemctl start postgresql
cat << EOF >> /etc/yum.repos.d/odoo.repo 
[odoo-nightly]
name=Odoo Nightly repository
baseurl=http://nightly.odoo.com/9.0/nightly/rpm/
enabled=1
gpgcheck=1
gpgkey=https://nightly.odoo.com/odoo.key
EOF

yum install odoo
systemctl start odoo
