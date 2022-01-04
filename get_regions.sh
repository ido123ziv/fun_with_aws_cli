#!/bin/bash
aws ec2 describe-regions | jq --raw-output ' .Regions | .[] | .RegionName'
