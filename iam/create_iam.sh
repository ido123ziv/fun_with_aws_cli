#!/bin/bash
export AWS_PAGER=""
​
​
echo -n 'Enter username (can also be multiple user names seperated with space)':
read usernames
echo -n 'Enter profile name (for exam account)':
read profile
​
​
for user in $usernames
do
    initial_password=$(openssl rand -base64 8)
    #Create user in AWS IAM
    echo Creating user: $user
    aws iam create-user --user-name $user --profile $profile
    
    #Attach administrator policy to the user
    echo Attaching AdministratorAccess policy for user: $user
    aws iam attach-user-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --user-name $user --profile $profile
    
    #Create password for the user and add policy to inforce password change on first login
    echo Creating initial password for user: $user
    aws iam create-login-profile --user-name $user --password $initial_password --password-reset-required --profile $profile
    
    # Print the username and password created for the user
    echo ------------------------------------------------
    echo the Username create is: $user
    echo the Password for this user is: $initial_password
    echo ------------------------------------------------
done