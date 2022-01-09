#!/bin/bash
aws ssm describe-parameters | jq --raw-output '.Parameters | .[] | .Name' | while read line
do 
    aws ssm get-parameter --name $line --with-decryption | jq --raw-output '.Parameter | .Name , .Value'
    echo
done