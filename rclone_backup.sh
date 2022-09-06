#!/bin/bash

### Bash script to run Rclone jobs, as well as create and manage log files ###
                        ### Written by Charlie Taylor ###

#Set Variables
log_file="/var/log/rclone/rclone.$(date +'%d-%m-%Y').log" #Sets up the log file name with a timestamp.
source_files="/path/to/files" #Path to the files you want to Backup
rclone_job="" #Name of Rclone Job to run e.g GoogleDrive_Encrypt
job_name="" #Name of the backup job. Purely for progress output to the terminal 

### Initialise the log file ###
echo "### BACKUP JOB IS STARTING ###" >> $log_file
echo "### $(date +"%T %d-%m-%Y ###")
" >> $log_file

### Backup of Files ###
echo "Running $job_name backup. "
rclone --log-level INFO --log-file $log_file sync $source_files/ $rclone_job: #Add file path for remote after $rclone_job: as required. (e.g. $rclone_job:/Documents)

### Closes off the log file ###
echo "### BACKUP COMPLETED AT $(date +"%T %d-%m-%Y ###")
" >> $log_file

### Cleanup old logs (Set the +5 value according to how many days worth of log you want to keep) ###
echo "Cleaning Up Log Files"
find /var/log/rclone/ -mtime +5 -exec rm {} \;

### Printing exit message to screen ###
echo "
*** RCLONE $job_name Backup ***
Backup complete. 
Logs available at $log_file
"  
