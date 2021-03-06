#!/bin/bash
# 一键删除k8s安装记录
rm -R /etc/kubernetes
rm -R /var/lib/etcd
rm -R /home/zks
rm /usr/bin/kube*
rm /usr/bin/etcd*
export KUBE_APISERVER=
# 停止服务
service etcd stop
service kube-apiserver stop
service kube-controller-manager stop
service kube-scheduler stop
service kubelet stop
service kube-proxy stop
systemctl stop etcd,kube-apiserver,kube-controller-manager,kube-scheduler,kubelet,kube-proxy
systemctl disable etcd,kube-apiserver,kube-controller-manager,kube-scheduler,kubelet,kube-proxy
rm /etc/systemd/system/etcd.service
rm /etc/systemd/system/kube-apiserver.service
rm /etc/systemd/system/kube-controller-manager.service
rm /etc/systemd/system/kube-scheduler.service
rm /etc/systemd/system/kubelet.service
rm /etc/systemd/system/kube-proxy.service

#重启
reboot