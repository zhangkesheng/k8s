#!/bin/bash

source ./config.sh

# 获取传入的参数
node=${node1}
while getopts "n:" arg
do
    case $arg in
         n)
            node="$OPTARG"
            ;;
         ?)
            echo "unkonw argument"
            return;
            ;;
    esac
done

if [ ! -d "/etcd/kubernetes" ]; then
    mkdir p /etcd/kubernetes
fi
echo "generate service config"
bash 1generate_service_config.sh masterIp

if [ ! -d "daemons" ]; then
  mkdir daemons
fi
export NODE_NAME=${node}
export NODE_IP=${node}
export ETCD_INITIAL_CLUSTER="etcd-${node1}:https://${node1}:2380,etcd-${node2}:https://${node2}:2380,etcd-${node3}:https://${node3}:2380"
export SERVICE_CLUSTER_IP_RANGE=${SERVICE_CLUSTER_IP_RANGE}
export CLUSTER_CIDR=${CLUSTER_CIDR}
export CLUSTER_DNS=${CLUSTER_DNS}
export EVICTION_HARD=${EVICTION_HARD}
bash etcd.sh
bash master.sh
bash node.sh
