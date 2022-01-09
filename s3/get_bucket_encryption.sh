#!/bin/bash
aws s3 ls | awk '{print $3}' | while read line ; do echo $line; aws s3api get-bucket-encryption --bucket $line; done
