#!/bin/sh

kubectl -n kube-system create configmap grafana-dashboard-config --from-file=grafana-dashboard-config.yaml
sleep 10

kubectl -n kube-system create configmap grafana-source-config --from-file=grafana-datasource.yaml
sleep 10 

curl "https://docs.portworx.com/samples/k8s/pxc/portworx-cluster-dashboard.json" -o portworx-cluster-dashboard.json && \
curl "https://docs.portworx.com/samples/k8s/pxc/portworx-node-dashboard.json" -o portworx-node-dashboard.json && \
curl "https://docs.portworx.com/samples/k8s/pxc/portworx-volume-dashboard.json" -o portworx-volume-dashboard.json && \
curl "https://docs.portworx.com/samples/k8s/pxc/portworx-performance-dashboard.json" -o portworx-performance-dashboard.json && \
curl "https://docs.portworx.com/samples/k8s/pxc/portworx-etcd-dashboard.json" -o portworx-etcd-dashboard.json && \
kubectl -n kube-system create configmap grafana-dashboards --from-file=portworx-cluster-dashboard.json --from-file=portworx-performance-dashboard.json --from-file=portworx-node-dashboard.json --from-file=portworx-volume-dashboard.json --from-file=portworx-etcd-dashboard.json

sleep 10 

kubectl apply -f grafana.yaml
sleep 10

echo "Grafana endpoint" 
kubectl get svc -n kube-system grafana
