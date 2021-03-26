#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cp elasticsearch.repo /etc/yum.repos.d/
cp kibana.repo /etc/yum.repos.d/
dnf -y install --enablerepo=elasticsearch elasticsearch
dnf -y install kibana
dnf -y install logstash
dnf -y install filebeat
cp kibana.yml /etc/kibana/
sed -i "s/serverip/$ip/g" /etc/kibana/kibana.yml
cp filebeat.yml /etc/filebeat/
sed -i "s/serverip/$ip/g" /etc/filebeat/filebeat.yml
filebeat modules enable nginx
filebeat modules enable apache
filebeat setup -e
systemctl daemon-reload
systemctl start elasticsearch
systemctl start kibana
systemctl start logstash
systemctl start filebeat