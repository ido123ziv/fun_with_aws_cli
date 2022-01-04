#!/bin/bash
# $1 is service name
CLUSTER=$(aws ecs list-clusters | jq --raw-output '.clusterArns | .[] ') 
SERVICE=$(aws ecs list-services --cluster $CLUSTER | jq --raw-output '.serviceArns | .[]' | grep $1)
aws ecs list-tasks --cluster $CLUSTER --service $SERVICE | jq --raw-output '.taskArns | .[]' | cut -d '/' -f3