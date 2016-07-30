The backup.sh script performs a backup of the files/directories specified in the includes.txt file.

# Including files/directories
The files/directories that you wish to be backed up must be placed into an includes.txt file in the same directory as the script. The files/directories will be passed to rsync verbatim, so make sure that they are correct and absolute.

# Excluding files/directories
Any excludes must be specified in a excludes.txt file in the working directory of the script. The file paths are parsed relative to the root directory, so for example, if backing up /home/web and wanting to exclude /home/web/beans.txt, then a /beans.txt exclude rule should be added.

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

## Email on error
- Install ssmtp and copy the ssmtp.conf file to /etc/ssmtp, making sure to enter the correct email address and password to send email from
- Copy the status-email-user systemd service to /etc/systemd/system
- Copy the systemd-email program to /usr/local/bin, ensuring that it is executable
- Test that you can send an email by running the following
```
systemd-email '<email address>' '<subject>'
```

# Running the script - automatically
A systemd timer can be set up to run the script automatically by copying the backup.service and backup.timer files to /etc/systemd/system and enabling (and starting) the backup timer. They include the ability to email on error, which can be set up by following instructions found at https://wiki.archlinux.org/index.php/Systemd/Timers#Caveats, or copying the configuration from existing machines.

You will need to manually change the systemd unit files to point to the correct directories and use the correct machine name, as well as updating the weekday in backup.timer to something not already used.

# Running the script - manually
The script requires the first argument to be the backup folder name on the backup drive. This will most likely be the machine name.
```
sh backup.sh orange
```
