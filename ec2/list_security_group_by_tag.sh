#!/bin/bash
# to run it use $1 for key_name and $2 for value
aws ec2 describe-security-groups --filters Name=tag:$1,Values=$2 