#! /bin/bash
KOPS_CLUSTER_NAME=" "
KOPS_STATE_STORE=" "

kops create cluster --node-count=2 --node-size=t2.micro --zones=us-east-1a
kops update cluster --name ${KOPS_CLUSTER_NAME} --yes
