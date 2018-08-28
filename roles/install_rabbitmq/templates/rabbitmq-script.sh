#!/bin/bash

service rabbitmq-server stop
killall beam.smp
killall epmd
rm -rf /var/lib/rabbitmq/mnesia
service rabbitmq-server start

rabbitmqctl stop_app

rabbitmqctl reset
rabbitmqctl status

sleep 1

rm -rf /var/lib/rabbitmq/mnesia/rabbit@{{ansible_hostname}}/*

rabbitmqctl start_app

rabbitmqctl add_user {{common.app_user}} {{common.app_user_password}}
rabbitmqctl add_vhost queue1

rabbitmqctl set_permissions -p queue1 {{common.app_user}} ".*" ".*" ".*"
rabbitmqctl status

sleep 1

/etc/init.d/rabbitmq-server status

rabbitmqctl add_user {{common.app_user}} {{common.app_user_password}}
rabbitmqctl set_user_tags {{common.app_user}} administrator
rabbitmqctl set_permissions -p / {{common.app_user}} ".*" ".*" ".*"
rabbitmqctl set_permissions -p queue1 {{common.app_user}} ".*" ".*" ".*"

rabbitmqctl list_queues -p queue1
