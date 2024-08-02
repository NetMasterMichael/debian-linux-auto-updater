#!/bin/sh

# Variable to path where logs will be created and stored
log_path=/home/vpn/auto-update-logs/logs-$(date +"%FT%T")

# Auto Updater
touch $log_path
sh /home/vpn/auto-update.sh > $log_path
