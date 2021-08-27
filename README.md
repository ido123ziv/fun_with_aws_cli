# fun_with_aws_cli
This repo contains `aws-cli` script with `bash` scripts to help with aws tasks that are difficult to do with the console.
Just chill in and use them with the services you use to help with day to day jobs with the cloud.

Enjoy!

## prerequisites
* install aws-cli
* configure aws credentials

To install `aws-cli` on Mac:
```
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

To install `aws-cli` on Linux:
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

To configure aws credentials:
```
aws configure
```

and fill in the promt or use one-by-one commands:

```
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID 
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY 
aws configure set region $REGION
```