# Learnkubernetes
步骤:
要选择一台服务器为主要操作机器, 在上面生成ca证书及token.csv
1. 修改param.sh 的参数
2. 选择一个做负载均衡服务器, 执行: `bash step0_set_nginx_load_balancing.sh`
3. 选择一个服务器, 执行ca里面的 `init.sh`, 并将pem文件cp到其他主机上
4. 执行 `bash step1_prepare.sh`
5. 将生成的 `/etc/kubernetes/token.csv` cp到其他服务器上
6. 执行 `bash step2_set_etcd.sh`, 需要在所有主机上同时执行
7. 检查etcd 状态 `etcdctl --ca-file=/etc/kubernetes/ssl/ca.pem --cert-file=/etc/kubernetes/ssl/kubernetes.pem --key-file=/etc/kubernetes/ssl/kubernetes-key.pem cluster-health`
8. 执行 `bash step3_kubernetes_master_clusters.sh`
9. 检查master状态 `kubectl get componentstatuses`
10. 手动添加授权
    `cd /etc/kubernetes \
    kubectl create clusterrolebinding kubelet-bootstrap \
      --clusterrole=system:node-bootstrapper \
      --user=kubelet-bootstrap`
11. 执行 `bash step4_kubernetes_node.sh`
12. 执行 `kubectl get csr`查看未授权的 CSR 请求, `kubectl certificate approve csr-2b308`通过 CSR 请求
