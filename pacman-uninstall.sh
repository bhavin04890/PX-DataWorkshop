#!/bin/bash

kubectl delete -n pacman -f dataprotection/rbac.yaml
kubectl delete -n pacman -f dataprotection/secret.yaml
kubectl delete -n pacman -f dataprotection/mongo-deployment.yaml
kubectl delete -n pacman -f dataprotection/pacman-deployment.yaml
kubectl delete -n pacman -f dataprotection/mongo-service.yaml
kubectl delete -n pacman -f dataprotection/pacman-service.yaml

if [[ $# -gt 0  && "$1" == "keeppvc" ]]
then
    echo "Keeping namespace and persistent volume claim"
else
    kubectl delete -n pacman -f dataprotection/mongo-pvc.yaml
    kubectl delete namespace pacman
fi
