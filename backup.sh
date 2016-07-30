#!/bin/bash

backupFolderName=$1
if [ -z "${backupFolderName}" ]; then
    echo "You must provide a folder name to backup to."
    exit 1
fi

# If the excludes file exists then we need to set it as an argument
excludesFilePath="./excludes.txt"
if [ -e "${excludesFilePath}" ]; then
    excludeFromArgument=" --exclude-from=${excludesFilePath}"
fi

# -a Archive
# -v Verbose
# -z Compression during transfer
# -H Preserve hardlinks
# -A Preserve access control lists
# -X Preserve extended attributes
# --delete Deletes extra files in destination
# --human-readable Outputs numbers in a human readable format
# --info=progress2 Outputs the total transfer progress
# sudo required to copy files with any permission
sudo rsync -avzHAX --delete --human-readable --info=progress2${excludeFromArgument} ~/* backup@green:/mnt/backup/${backupFolderName}/
