#!/bin/bash
# $1 is a security group to check, default is the default sg
# $2 is a region to check, default is the default eu-west-1
SECURITY_GROUP=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=default")
if [[ ! -z $1 ]]; then
    SECURITY_GROUP=$1
REGION="eu-west-1"
if [[ ! -z $2 ]]; then
    REGION=$2
aws ec2 describe-network-interfaces --filters Name=group-id,Values=$SECURITY_GROUP --region $REGION --output json  --query 'NetworkInterfaces[*]'.['NetworkInterfaceId','Description','PrivateIpAddress','VpcId']
