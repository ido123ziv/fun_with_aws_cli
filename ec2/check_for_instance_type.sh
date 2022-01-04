#!/bin/bash
# this script checks whether specific instance type is available in each region
# $1 is the instance_type
if [[ ! -z $1 ]]; then
    INSTANCE_TYPE=$1
else
    INSTANCE_TYPE=g4dn.2xlarge

aws ec2 describe-regions | jq --raw-output ' .Regions | .[] | .RegionName' | while read line
do 
    echo region is: $line
    aws ec2 describe-instance-type-offerings --region $line --location-type availability-zone --filters Name=instance-type,Values=$INSTANCE_TYPE
done