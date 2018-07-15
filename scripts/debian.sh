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
mkdir ~/.new

curlLoc="$(which curl)"
mv ${curlLoc} ~/.new

wgetLoc="$(which wget)"
mv ${wgetLoc} ~/.new

ncLoc="$(which nc)"
mv ${ncLoc} ~/.new

netcatLoc="$(which netcat)"
mv ${netcatLoc} ~/.new

ncatLoc="$(which ncat)"
mv ${ncatLoc} ~/.new

