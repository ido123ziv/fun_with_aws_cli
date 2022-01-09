#!/bin/bash
# $1 is a security group to check, default is the default sg
# $2 is a region to check, default is the default eu-west-1
if [[ ! -z $1 ]]; then
    PROFILE=$1
fi
SECURITY_GROUP=$(aws ec2 describe-security-groups --profile $PROFILE --filters "Name=group-name,Values=default")
if [[ ! -z $2 ]]; then
    SECURITY_GROUP=$2
fi
REGION="eu-west-1"
if [[ ! -z $3 ]]; then
    REGION=$3
fi
aws ec2 describe-security-groups --query "SecurityGroups[].{Name:GroupName,Id:GroupId}" --region $REGION --profile $PROFILE | jq -c  " .[] " | while read line
do
    NAME=$(echo $line | jq ' .Name ')
    SECURITY_GROUP=$(echo $line | jq ' .Id ')
    echo SG is: $NAME
    aws ec2 describe-network-interfaces --filters Name=group-id,Values=$SECURITY_GROUP --region $REGION --profile $PROFILE --output json  --query "NetworkInterfaces[*].[NetworkInterfaceId,Description,PrivateIpAddress,VpcId]"
done