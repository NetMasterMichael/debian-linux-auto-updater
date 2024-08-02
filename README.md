# debian-linux-auto-updater
This is a script for automatically downloading and installing updates on a Debian-based Linux operating system that I created back in 2022 for my personal use. I thought I would share it along with some instructions, in case others find it useful.

I originally created this for my Raspberry Pi running [PiVPN](https://github.com/pivpn/pivpn). Since it is publicly exposed to the Internet so that I may connect to the VPN service, I want the latest security updates to always be installed to minimise any risk of infiltration. However, this script is compatible with any Debian-based Linux operating system that has the `apt` package manager.

## ⚠ Disclaimer ⚠
**THIS SCRIPT IS NOT INTENDED FOR COMMERCIAL USE IN ENTERPRISE ENVIRONMENTS.**

Software updates generally bring positive changes, such as fixing bugs, patching up security holes and adding new useful features. However, operating systems are incredibly complex pieces of software with an unimaginable number of moving parts, and updates can also sometimes introduce new bugs, open new security holes, and in extreme cases, crash your OS and/or render it unbootable. This might sound unrealistic, but I have witnessed this first-hand in the industry. This is why businesses usually wait some time before deploying non-critical updates to its servers and desktops, typically 1-2 weeks at the bare minimum.

In my instance, I have this script run frequently, because I accept the risk of potential damage to my operating system and I am prepared to handle fixing it. If things go badly, it causes a headache to nobody else but me. But I would never use or endorse anything like this in an enterprise production environment, where an outage could cause financial damages to a business.

Although the risk is low, it's still there. By using this script, you accept the risk of damage to your operating system from installing updates automatically without prior review and take full responsibility. I am not liable for any damages caused. You have been warned!

## Setup
Now that the important disclaimer is out of the way, we can move onto the setup process. It is very simple to setup and configure.

Explanation of each file:
- `initiate-auto-update.sh` - Wrapper script for `auto-update.sh`. Writes the output of each command to a log file inside `auto-update-logs/` with the date & time in ISO 8601 format for the name of the file.
- `auto-update.sh` - Script that uses the `apt` package manager to update the system. Outputs the start time, each update downloaded & installed and the finish time.
- `auto-update-logs/` - Folder for storing logs produced by `initiate-auto-update.sh`

Pre-requisites:
- Must be on a Debian-based Linux operating system with the `apt` package manager installed. Other package managers are not supported, but you are welcome to modify the script to use your package manager of choice.
- It is recommended to have Git installed, for easily cloning the repo to your machine, but not essential

### Step 1: Cloning the repo
Firstly, clone the repository to your own machine using the command below.
```bash
git clone https://github.com/NetMasterMichael/debian-linux-auto-updater.git
```
Alternatively, you can copy and paste the scripts from a web browser onto your own system. Ensure the scripts are marked as executable with `chmod +X filename-goes-here`.

### Step 2: Scheduling the script
Next, we can use a tool called cron to schedule the script to run at regular times.

Since package managers require root permissions to install system updates, we will need to call cron with sudo, so that the script is executed as root.

You can use the command below to open the crontab file.
```bash
sudo crontab -e
```
This will open the crontab file in a text editor, such as nano. To add cron jobs, add a line at the bottom of the file that specifies the time and frequency that a command should run (called a cron expression). Below is shown what you'd add to run updates at 00:00 and 12:00 daily.
```
0 0,12 * * * sh /home/vpn/debian-linux-auto-updater/initiate-auto-update.sh
```
Save the script and exit the text editor. The script is now scheduled to automatically execute, based on the parameters you have provided.

Cron expressions are incredibly flexible. For a guide on creating cron expressions with examples, [see this document written by Oracle](https://docs.oracle.com/cd/E12058_01/doc/doc.1014/e12030/cron_expressions.htm).
