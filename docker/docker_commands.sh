#!/bin/bash

# build a new image with arguments
docker build --build-arg ARG1=$ARG1 --build-arg ARG2=$ARG2 -t $REPOSITORY_URI:latest -f Dockerfile .

# delete images that wasn't build well
docker rmi $(docker image ls | grep none | awk '{print $3}')

# get arguments from parameter store
aws ssm describe-parameters | jq --raw-output '.Parameters | .[] | .Name' > args
aws ssm get-parameters --names $(cat args) --with-decryption --region us-east-1 | jq --raw-output '.Parameters | .[] | .Value'
aws ssm get-parameters --names $(cat args) --with-decryption --region us-east-1 | jq --raw-output '.Parameters | .[] | .Name'

# run the container with root privilieges
docker run  -d --privileged --name net01 -p 80:80 -p 4000-4001:4000-4001 $REPOSITORY_URI:latest /usr/sbin/init
# connect to container
docker exec -it net01 /bin/bash
# delete container
docker rm -f net01
# run a second container
docker run  -d --privileged --name net02 -p 82:80 -p 4002-4003:4000-4001 $REPOSITORY_URI:latest /usr/sbin/init

# delete specific image
docker rmi $REPOSITORY_URI:$TAG
# get reposotry URI from ecr
REPO_URI=$(aws ecr describe-repositories --region us-east-1 | grep app | grep Uri | awk '{print $2}' | tr -d '"' | tr -d ',')
# kill all container
docker rm -f $(docker ps -a | grep -v IMAGE | awk '{print $1}')
