#!/bin/bash
# to run it use $1 for key_name and $2 for value
aws ec2 describe-security-groups --filters Name=tag:$1,Values=$2 --profile $3 | grep "GroupId" > sgs.txt
cat sgs.txt | awk '{print $2}' | tr -d '"' | tr -d ',' > sgs.txt
KEY=$1
VALUE=$2

cat sgs.txt | while read line
do
    aws ec2 delete-tags --resources $line --tags Key=$KEY,Value=$VALUE --profile $3
done

rm sgs.txt