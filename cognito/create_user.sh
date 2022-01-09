#!/bin/bash
##########################################
# $1 user pool
# $2 username
# $3 user new password
##########################################
echo pool is: $1
POOL=$1
echo username is: $2
USERNAME=$2
echo password $3
PASSWORD=$3
aws cognito-idp admin-create-user --user-pool-id $POOL --username $USERNAME 
aws cognito-idp admin-set-user-password \
    --user-pool-id $POOL \
    --username $USERNAME \
    --permanent \
    --password $PASSWORD 