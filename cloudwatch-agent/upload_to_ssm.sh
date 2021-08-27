#!/bin/bash
aws ssm put-parameter --name AmazonCloudWatch-Linux --value $(cat AmazonCloudWatch-Linux.json) --type String --tags \  
    Key=OS,Value=Linux