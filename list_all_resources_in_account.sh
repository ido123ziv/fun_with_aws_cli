#!/bin/bash
# $1 is profile
PROFILE="default"
if [[ ! -z $1 ]]; then
    PROFILE=$1
fi
aws ec2 describe-regions --query "Regions[*].{Region:RegionName}" --output text --profile $PROFILE | while read line
do
    echo region is: $line
    aws resourcegroupstaggingapi get-resources --region $line --query "ResourceTagMappingList[].{Resource:ResourceARN}" --profile $PROFILE
done