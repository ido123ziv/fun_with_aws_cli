#!/bin/bash
# give it an argument of the cluster-name
aws ecs list-services --cluster $1 | jq --raw-output '.serviceArns | .[] ' | cut -d '/' -f3 | while read line 
do 
    aws ecs update-service --service $line --enable-execute-command --cluster $1
done 
# list services that can exec into:
aws ecs list-services --cluster networkleads-cluster | jq --raw-output '.serviceArns | .[] ' | cut -d '/' -f3 | while read line
do 
    echo $line
    aws ecs describe-services --cluster networkleads-cluster --service $line | grep enableExecuteCommand 
    sleep 1 
done