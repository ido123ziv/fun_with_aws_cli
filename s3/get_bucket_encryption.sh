#!/bin/bash
if [[ ! -z $1 ]]; then
    PROFILE=$1
fi
aws s3 ls --profile $PROFILE | awk '{print $3}' | while read line ; do echo $line; aws s3api get-bucket-encryption --bucket $line --profile $PROFILE; done
