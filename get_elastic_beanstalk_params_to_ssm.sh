#!/bin/bash
# $1 is env name. $2 is app name
echo "Getting environment vars from EB"
aws elasticbeanstalk describe-configuration-settings --environment-name $1 --application-name $2 | jq '.ConfigurationSettings | .[].OptionSettings | .[] | if .OptionName == "EnvironmentVariables" and .Namespace == "aws:cloudformation:template:parameter" then .Value else ""end' > dataVars
echo "Wait While I'm parsing the Vars"
cat dataVars | tr -d '"' | tr -d '\n' > dataVars
sed -i 's/,/\n/g' dataVars
echo "Done parsing, uploading to ssm now :)"
PARAM_NAME="NAME"
PARAM_VALUE="VALUE"
cat dataVars | while read line
do
  PARAM_NAME=$(echo $line | cut -d '=' -f1)
  PARAM_VALUE=$(echo $line | cut -d '=' -f2)
  aws ssm put-parameter --name $PARAM_NAME --value $PARAM_VALUE --type SecureString
  echo "done with ${PARAM_NAME}"
done 
rm -f dataVars
