#!/bin/sh
echo =============================
echo START OF UPDATES
echo TIME: $(date +"%FT%T")
echo =============================
sudo apt update && sudo apt full-upgrade -y
# sudo rpi-update -y
sudo apt autoremove -y
sudo apt autoclean -y
echo =============================
echo END OF UPDATES
echo TIME: $(date +"%FT%T")
echo =============================
