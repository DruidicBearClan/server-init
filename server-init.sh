#~/bin/bash

#Require root permissions
if [ "$EUID" -ne 0 ];
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

#Install NTP
apt install ntp

#Replace contents of /et/ntp.conf
cat ntp.conf > /etc/ntp.conf

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

#Enable firewall and allow ssh

ufw allow ssh
ufw --force enable
ufw reload
ufw status numbered

#Add public key thumbprint to authorized keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINsxMWaQgyUDfRKch5bFnOQsuoGYLOHPfeGt1veyMChc ll@ouroboros' > /home/$USER/.ssh/authorized_keys

#Enable pub key only SSH authentication and restart SSH
sed 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
sed 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
service ssh restart

#Write out the current crontab into a file
echo creating temporary file mycron
crontab -u ll -l > mycron

#echo a new cronjob into cron file for system updates. Scheduled weekly, on Sunday night 03:00 AM.
echo installing a new cronjob to ll users crontab from this file
echo "0 3 * * SUN apt update && apt upgrade -y && apt autoremove -y && shutdown -h now" > mycron

#install the new cron file as cronjob
crontab -u ll mycron

#remove temp cron file
echo removed temporary file mycron, new cronjob has been configured for updates on Sunday night 03:00
rm mycron