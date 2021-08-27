#!/bin/bash
# pass to script acount_number, cluster_name, REGION to work
# $1 = role-session-name $2 = aws profile $3 = role name
aws sts assume-role --role-arn arn:aws:iam::{$acount_number}:role/$3 --role-session-name $1 --profile $2 > creds.json
echo "done stsing"
AWS_ACCESS_KEY_ID=$(cat creds.json | grep AccessKeyId | awk '{print $2}' | tr -d '"' | tr -d ',')
echo $AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY=$(cat creds.json | grep SecretAccessKey | awk '{print $2}' | tr -d '"' | tr -d ',')
echo $AWS_SECRET_ACCESS_KEY
AWS_SESSION_TOKEN=$(cat creds.json | grep SessionToken | awk '{print $2}' | tr -d '"' | tr -d ',')
echo $AWS_SESSION_TOKEN
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID --profile temp
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY --profile temp
aws configure set aws_session_token $AWS_SESSION_TOKEN --profile temp
aws configure set region $REGION --profile temp
tail -5 ~/.aws/credentials
aws eks update-kubeconfig --name {$cluster_name} --region $REGION --profile temp