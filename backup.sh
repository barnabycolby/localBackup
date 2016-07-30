#!/bin/bash

backupFolderName=$1
if [ -z "${backupFolderName}" ]; then
    echo "You must provide a folder name to backup to."
    exit 1
fi

# Our source files come from an includes.txt file, we need to throw an error if we cannot find it
backupDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
includesFilePath="${backupDirectory}/includes.txt"
if [ -e "${includesFilePath}" ]; then
    includeArgument="$(cat ${includesFilePath})"
else
    echo "You must provide an includes.txt file so I know what to backup."
    exit 2
fi

# If the excludes file exists then we need to set it as an argument
excludesFilePath="${backupDirectory}/excludes.txt"
if [ -e "${excludesFilePath}" ]; then
    excludeFromArgument=" --exclude-from=${excludesFilePath}"
fi

# -a Archive
# -v Verbose
# -z Compression during transfer
# -H Preserve hardlinks
# -A Preserve access control lists
# -X Preserve extended attributes
# --relative Preserves the directory structure in the destination
# --delete Deletes extra files in destination
# --human-readable Outputs numbers in a human readable format
# --info=progress2 Outputs the total transfer progress
# sudo required to copy files with any permission
sudo rsync -avzHAX --relative --delete --human-readable --info=progress2${excludeFromArgument} ${includeArgument} backup@green:/mnt/backup/${backupFolderName}/
