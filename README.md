The backup.sh script performs a backup of the users home directory (i.e. ~/\*).

# Excluding files/directories
Any excludes must be specified in a excludes.txt file in the working directory of the script.

# Setup
## SSH Key access
- As the script runs rsync using the sudo command, the root users ssh public key needs to be authorized by the backup server
- If the client machine root user does not already have an SSH key, generate a key pair with the following command. Make sure not to give the key a passphrase as this will prevent the script from running automatically
```
ssh-keygen -t rsa
```
- Copy the public key to the backup server
```
ssh-copy-id backup@green
```

# Running the script - manually
The script requires the first argument to be the backup folder name on the backup drive. This will most likely be the machine name.
```
sh backup.sh orange
```
