#!/bin/bash
aws backup list-copy-jobs | grep CopyJobId | cut -d ':' -f2 | tr -d '"' | tr -d ' ' | tr -d ',' | while read line 
do 
    aws backup describe-copy-job --copy-job-id $line | jq '.CopyJob | if .State == "COMPLETED" then "" else .CopyJobId end' | tr -d '"'
done