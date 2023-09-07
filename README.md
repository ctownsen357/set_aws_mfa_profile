# set_aws_mfa_profile
A helper script to setup the needed MFA tokens for aws cli use. Prompts the user for each piece of information needed. Automatically determines the ARN for the mfa device used by the user's account.

Example runtime usage:
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
