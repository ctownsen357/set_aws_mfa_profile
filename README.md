# set_aws_mfa_profile
A helper script to configure the needed MFA tokens for aws cli use. Prompts the user for each piece of information needed. Automatically determines the ARN for the mfa device used by the user's account.

AWS CLI with MFA requires one to use their assigned account tokens to generate a separate set of temporary tokens that are authorized by a call to the account that passes an MFA token. These temporary credentials may then be added to another profile and used without the need to provide an MFA token again until after the temporary tokens have expired. This script automates those calls and sets the credentials for the temporary MFA profile. 

## Required Software
- AWS CLI
- bash
- jq

## AWS CLI Profile Requirements
Assumes you've configured your account credentials in a profile and a separate mfa profile that this script will update with the temporary credentials.

## Example runtime usage:
```
./set_mfa_profile.sh

Enter existing AWS CLI profile (e.g., default):
myaccount
Enter MFA token:
791145
Enter the MFA profile name to update:
myaccount_mfa
MFA session credentials set and AWS_PROFILE environment variable updated
```

