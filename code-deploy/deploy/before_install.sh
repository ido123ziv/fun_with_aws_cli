#!/bin/bash

DEPLOYMENT_SRC=/opt/codedeploy-agent/deployment-root/$DEPLOYMENT_GROUP_ID/$DEPLOYMENT_ID/deployment-archive
DEPLOYMENT_DST=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID

mkdir $DEPLOYMENT_DST

echo "Copy to tmp deployment folder"
rsync -r --exclude-from=$DEPLOYMENT_SRC/deploy/.exclude $DEPLOYMENT_SRC/ $DEPLOYMENT_DST

cd $DEPLOYMENT_DST

echo "Install composer"
/bin/sh $DEPLOYMENT_SRC/deploy/install_composer.sh

echo "Run composer install"
./composer.phar i --no-interaction --prefer-dist --optimize-autoloader

echo "Remove composer.phar"
rm -f composer.phar