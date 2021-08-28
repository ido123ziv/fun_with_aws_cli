#!/bin/bash
aws s3 ls | while read line
do 
    echo $line | awk '{print $3}'
    echo $line | aws s3 ls s3://$(awk '{print $3}') --recursive --human-readable --summarize | grep "Total Size" 
done