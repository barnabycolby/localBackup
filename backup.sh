#!/bin/bash

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
sudo rsync -avzHAX --delete --human-readable --info=progress2 --exclude-from=/home/barnaby/Backup/excludes.txt ~/* backup@green:/mnt/backup/barnaby/
