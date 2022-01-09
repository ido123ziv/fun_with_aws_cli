#!/bin/bash

DEPLOYMENT_SRC=/tmp/deploy-$DEPLOYMENT_GROUP_ID-$DEPLOYMENT_ID
DEPLOYMENT_DST=/var/www/html
DEPLOYMENT_TMP=`mktemp -d`

echo "Fix permissions"
chown -R nginx:nginx $DEPLOYMENT_SRC
find $DEPLOYMENT_SRC -type d -exec chmod 770 {} \;
find $DEPLOYMENT_SRC -type f -exec chmod 660 {} \;

echo "Move folder into place"
mv $DEPLOYMENT_DST $DEPLOYMENT_TMP && mv $DEPLOYMENT_SRC $DEPLOYMENT_DST && rm -rf $DEPLOYMENT_TMP