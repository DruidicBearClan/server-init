#!/bin/bash

#Require root permissions
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#Generate default US/NL locales
locale-gen en_US.UTF-8
locale-gen nl_NL.UTF-8

#Update default locales
update-locale LANG=en_US.UTF-8
update-locale LC_CTYPE="en_US.UTF-8"
update-locale LC_NUMERIC=nl_NL.UTF-8
update-locale LC_TIME=nl_NL.UTF-8
update-locale LC_COLLATE="en_US.UTF-8"
update-locale LC_MONETARY=nl_NL.UTF-8
update-locale LC_MESSAGES="en_US.UTF-8"
update-locale LC_PAPER=nl_NL.UTF-8
update-locale LC_NAME=nl_NL.UTF-8
update-locale LC_ADDRESS=nl_NL.UTF-8
update-locale LC_TELEPHONE=nl_NL.UTF-8
update-locale LC_MEASUREMENT=nl_NL.UTF-8
update-locale LC_IDENTIFICATION=nl_NL.UTF-8

#Set Timezone
timedatectl set-timezone Europe/Amsterdam

#Disable local systemd timesyncd service
timedatectl set-ntp off

#Install NTP and SMTP services
apt install ntp apt install snmpd snmp libsnmp-dev -y

#Replace contents of /etc/ntp.conf
cat ntp.conf > /etc/ntp.conf

#Replace contents of /etc/snmp/snmpd.conf
cat snmpd.conf > /etc/snmp/snmpd.conf

#Restart NTP Service
systemctl restart ntp

#Check timesync queue
ntpq -p

#Remove Snaps and snapd package
snap remove lxd
snap remove core20
snap remove snapd

apt remove snapd -y

#remove old packages
apt autoremove -y

#Add public key thumbprint to authorized keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOK1w0/MCpeRujflcNsuR6kWLVtNUjPFpjpE1po1wxCp ll@ouroboros' > /home/ll/.ssh/authorized_keys

#write out current crontab
crontab -l > mytempcron

#echo new cronjobs for weekly updates into temp cron file
echo "50 19 * * 7 /usr/bin/apt update -q -y >> /var/log/apt/automaticupdates.log" >> mytempcron
echo "0 20 * * 7 /usr/bin/apt upgrade -q -y >> /var/log/apt/automaticupdates.log" >> mytempcron
echo "30 20 * * 7 /sbin/shutdown -r now" >> mytempcron
echo "@reboot chmod 444 /sys/devices/virtual/dmi/id/product_serial" >> mytempcron

#install new cronjobs and remove temp cron file
crontab mytempcron
rm mytempcron

echo system is now setup for weekly updates