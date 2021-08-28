# fun_with_aws_cli
This repo contains `aws-cli` script with `bash` scripts to help with aws tasks that are difficult to do with the console.
Just chill in and use them with the services you use to help with day to day jobs with the cloud.

## How To Use?
To run of the scripts, use `./name_of_script.sh` and look for parameters to give it (each script has a comment with the args needed)

For example, `get_elastic_beanstalk_params_to_ssm.sh` uses two arguments, one for `elastic-beanstalk` environment and another for `elastic-beanstalk` application.
To use the script run the following:

```bash
./get_elastic_beanstalk_params_to_ssm.sh your_env_name your_app_name
```

###Enjoy!

#### Fun Fact
I like to use `aws ssm` which is AWS System Manager service, you can find in this repo a lot of commands and scripts that uses it but no specific folder needed, `ssm` is out there helping to all other service because it is awesome.

## Prerequisites
* install aws-cli
* configure aws credentials

To install `aws-cli` on Mac:
```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

To install `aws-cli` on Linux:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

To configure aws credentials:
```bash
aws configure
```

and fill in the promt or use one-by-one commands:

```bash
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID 
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY 
aws configure set region $REGION
```
