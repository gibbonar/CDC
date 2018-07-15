#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

# Make passwd and shadow files immutable.
sudo chattr +i /etc/passwd
sudo chattr +i /etc/shadow

# Remove standard iptables binary to nullify red team scripts that call iptables. Use 'xtables-multi iptables' if needed.

iptLocation="$(which iptables)"
rm ${iptLocation}

# Backup current binaries. 
tar -zcvf bin.tar.gz /bin /sbin /usr/bin /usr/sbin

# Baseline modules.
lsmod >> lsmod.orig

# Baseline processes.
ps -ef >> ps.orig

# Baseline network connections
netstat -tulpan >> net.orig

# Baseline path
echo $PATH >> path.orig

# Move common redteam binaries to new location
mkdir ~/.bin

curlLoc="$(which curl)"
mv ${curlLoc} ~/.bin

wgetLoc="$(which wget)"
mv ${wgetLoc} ~/.bin

ncLoc="$(which nc)"
mv ${ncLoc} ~/.bin

netcatLoc="$(which netcat)"
mv ${netcatLoc} ~/.bin

ncatLoc="$(which ncat)"
mv ${ncatLoc} ~/.bin

