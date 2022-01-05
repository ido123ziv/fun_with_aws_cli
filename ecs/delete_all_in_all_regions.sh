#!/bin/bash
aws ec2 describe-regions | jq -r '.Regions[] | .RegionName' |  while read line
do
    echo region: $line
    CLUSTERS=$(aws ecs list-clusters --region $line  --query 'clusterArns[]' --output text)
    if [[ ! -z $CLUSTERS ]]; then
        aws ecs list-clusters --region $line  --query 'clusterArns[]' | jq ' .[] ' | while read cluster
        do
            echo cluster: $cluster
            SERVICES=$(aws ecs list-services --region $line --cluster $cluster --query 'serviceArns')
            if [[ ! -z $SERVICES ]]; then
                aws ecs list-services --region $line --cluster $cluster --query 'serviceArns' | jq ' .[] ' | while read service
                do
                    echo service: $service
                    aws ecs delete-service --cluster $cluster --service $service --force --region $line 
                done
            fi
            TASKS=$(aws ecs list-tasks --cluster $CLUSTER --region $line --query 'taskArns[]')
            if [[ ! -z $TASKS ]]; then
                aws ecs list-tasks --cluster $CLUSTER --query 'taskArns[]' --region $line | jq -r ' .[] ' | while read task
                do
                    echo task: $task
                    aws ecs delete-task --task $task --cluster $CLUSTER --region $line 
                done
            fi
    fi
done