#!/bin/bash

# Prompt user for existing AWS profile
echo "Enter existing AWS CLI profile (e.g., default):"
read existing_profile

# Use AWS CLI to obtain user ARN
USER_ARN=$(aws iam get-user --profile $existing_profile | jq -r .User.Arn)

# Construct MFA ARN from the user ARN
MFA_ARN="${USER_ARN/user\//mfa/}"

# Prompt user for MFA token
echo "Enter MFA token:"
read token_code

# Use AWS CLI to get session token
response=$(aws sts get-session-token --serial-number $MFA_ARN --token-code $token_code --profile $existing_profile)

# Extract AccessKeyId, SecretAccessKey, and SessionToken
ACCESS_KEY=$(echo $response | jq -r .Credentials.AccessKeyId)
SECRET_KEY=$(echo $response | jq -r .Credentials.SecretAccessKey)
SESSION_TOKEN=$(echo $response | jq -r .Credentials.SessionToken)

# Prompt user for AWS_PROFILE value to be set
echo "Enter the MFA profile name to update:"
read mfa_profile

# Update ~/.aws/credentials file with new values under the provided mfa profile
aws configure set aws_access_key_id $ACCESS_KEY --profile $mfa_profile
aws configure set aws_secret_access_key $SECRET_KEY --profile $mfa_profile
aws configure set aws_session_token $SESSION_TOKEN --profile $mfa_profile

# Set AWS_PROFILE environment variable
export AWS_PROFILE=$mfa_profile

echo "MFA session credentials set and AWS_PROFILE environment variable updated."

