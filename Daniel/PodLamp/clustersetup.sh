#! /bin/bash
KOPS_CLUSTER_NAME=potato2.k8s.local
KOPS_STATE_STORE=s3://potato2-kop-state-store

kops create cluster --node-count=2 --node-size=t2.micro --zones=us-east-1a
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
