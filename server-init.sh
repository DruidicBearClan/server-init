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

#Disable local timesync daemon
timedatectl set-ntp off

#Install NTP
apt install ntp

#Replace contents of /et/ntp.conf
cat ntp.conf > /etc/ntp.conf

#Restart NTP Service
systemctl restart ntp

#Check timesync queue
ntpq -p


