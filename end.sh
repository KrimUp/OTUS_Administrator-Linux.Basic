#!/bin/bash
#Проверка на выполение от пользователя root
if [ `whoami` = root ]
then
{
    setenforce 0

    #установка ПО с помощью пакетного менеджера
    dnf -y install nano
    dnf -y install wget
    dnf -y install mysql-server
    #установка балансировщика nginx
    sh Loadbalancerd/loadbalancer.sh
    #установка prometheus
    sh Prometheus/prometheus.sh
    #установка ELK
    sh ELK/elk.sh
    #установка MySQL к сожалению в ручном режиме
    
}
else
echo "Для выполения данного скрипта необходимы права root, введите sudo перед именем скрипта"
fi