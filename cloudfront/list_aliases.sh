#!/bin/bash
# $1 is the profile
PROFILE="default"
if [[ ! -z $1 ]]; then
    PROFILE=$1
fi
######################################################
# This part checks if jq is installed on the machine #
######################################################
echo '{"foo": 0}' | jq .
if [[ $? == 0 ]]; then
    # with jq
    aws cloudfront list-distributions --profile $PROFILE | jq --raw-output '.DistributionList | .Items | .[] | .Aliases | if .Quantity == 0 then "null" else .Items[] end' | grep -v "null"
else
    # without jq
    aws cloudfront list-distributions --query "DistributionList.Items[].{ARN:ARN,Aliases:Aliases}[?not_null(Aliases.Items)]" --profile $PROFILE 
fi