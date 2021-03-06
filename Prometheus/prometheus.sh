#!/bin/bash
#установка Prometheus
useradd -m -s /bin/false prometheus
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus /var/lib/prometheus/
wget https://github.com/prometheus/prometheus/releases/download/v2.25.2/prometheus-2.25.2.linux-amd64.tar.gz
tar -zxpvf prometheus-*.*.*.linux-amd64.tar.gz
cp prometheus-*.*.*.linux-amd64/prometheus  /usr/local/bin
cp prometheus-*.*.*.linux-amd64/promtool  /usr/local/bin
cp Prometheus/prometheus.yml  /etc/prometheus/
cp Prometheus/prometheus.service /etc/systemd/system
#установка node_exporter
useradd -m -s /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.1.2/node_exporter-1.1.2.linux-amd64.tar.gz
tar -zxpvf node_exporter-*.*.*.linux-amd64.tar.gz
cp node_exporter-*.*.*.linux-amd64/node_exporter /usr/local/bin
chown node_exporter:node_exporter /usr/local/bin/node_exporter
cp Prometheus/node_exporter.service /etc/systemd/system
#включение демонов prometheus и node_exporter
systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter
systemctl start prometheus
systemctl enable prometheus