#!/bin/bash
#  pass as an argument the aws profile for that
aws elbv2 describe-load-balancers --profile $1 | grep DNSName | cut -d ':' -f2 | tr -d '"' | tr -d ',' > lbs
# by loadbalancer ip!
cat lbs | while read lb
do 
    nslookup $lb | grep Address | awk '{print $2}' | grep -v "#" | while read line 
        do 
            echo curling $line
            curl -i $line
            echo moving forwards
            echo
        done
done
# by loadbalancer name!
cat lbs | while read lb
do 
    echo curling $line
    curl -i $line
    echo moving forwards
    echo
done