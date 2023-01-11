# AWS MFA Scripts

### Setup

- Clone this repo
- Global search and replace `{ABSOLUTE_PATH_TO_REPO}` with the absolute path to this repo e.g. `~/aws-mfa-cli-script`
- Add absolute path to this repo to your PATH
  - Add this to your `.zshrc` or similar: `export PATH=$PATH:$HOME/{RELATIVE_PATH_TO_REPO}`
- `cp aws-mfa-helpers/sample-aws-mfa-profiles.mjs aws-mfa-helpers/aws-mfa-profiles.mjs`

### Adding new account

- Add credentials to `~/.aws/credentials` as normal:
```
[{PROFILE_NAME}]
aws_access_key_id = {ACCESS_KEY_ID}
aws_secret_access_key = {SECRET_ACCESS_KEY}
```
- Add new profile to `aws-mfa-helpers/aws-mfa-profiles.mjs` with your `mfaArn` and `awsProfile`

### Using

- `aws-mfa {PROFILE} {CODE}`
    - This will create a new profile in `~/.aws/credentials` called `mfa-{PROFILE}` which you can now use
    - It will expire after 1 hour so you will need to re run the `aws-mfa` command then
- `aws-mfa {PROFILE} {CODE} -d`
    - This will set your default profile as the mfa profile
    - It will expire after 1 hour so you will need to re run the `aws-mfa` command then
- `aws-mfa -t`
    - This will tell you the last profile you called this with
