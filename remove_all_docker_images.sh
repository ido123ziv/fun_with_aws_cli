#!/bin/bash
docker images | grep -v TAG | awk '{print $3}' | while read line
do 
    docker rmi $line
done