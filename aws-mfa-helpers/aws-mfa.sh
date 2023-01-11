#!/bin/bash

if [ $# -ne 3 ] && [ $# -ne 4 ]; then
    echo -e 'Incorrect number of arguments. Please run:\n\taws-mfa {AWS_PROFILE} {MFA_SERIAL_CODE} {MFA_TOKEN} {?-d}'
    exit
fi
TOKEN_CODE=$3
AWS_PROFILE=$1
MFA_PROFILE="mfa-${AWS_PROFILE}"

SERIAL_NUMBER=$2

AWS_RESPONSE=$(aws sts get-session-token --serial-number $SERIAL_NUMBER --token-code $TOKEN_CODE --profile $AWS_PROFILE --duration-seconds 3600 --output text)
AWS_ACCESS_KEY_ID=$(echo $AWS_RESPONSE | awk {'print $2'})
AWS_SECRET_ACCESS_KEY=$(echo $AWS_RESPONSE | awk {'print $4'})
AWS_SESSION_TOKEN=$(echo $AWS_RESPONSE | awk {'print $5'})

aws configure --profile $MFA_PROFILE set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure --profile $MFA_PROFILE set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure --profile $MFA_PROFILE set aws_session_token $AWS_SESSION_TOKEN

if [ $4 = "-d" ]; then
    echo 'Setting default'
    aws configure --profile default set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure --profile default set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure --profile default set aws_session_token $AWS_SESSION_TOKEN
fi

echo "New Profile: $MFA_PROFILE"
echo "$MFA_PROFILE" | pbcopy
echo "Profile: $AWS_PROFILE last called at $(date)" > {ABSOLUTE_PATH_TO_REPO}/aws-mfa-helpers/aws-mfa-last-called.txt