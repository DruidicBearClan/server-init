This is my Ubuntu server initialization script

It will generate some required locales, disable local systemd timesyncd service, install ntp package,
replace ntp.conf with the one from this project, and then configures the server as an ntp-client to the server specified inside the ntp.conf.

It will then go on to remove snap server packages, enable default firewall with allow ssh rules, add my public key thumbprint to authorized_keys.

Then it changes sshd configuration to disallow root login and user password authentication.
After that a cronjob is scheduled under my account to run weekly updates.

This file mostly exists for my own server env, because I got tired of doing all the basic stuff over and over.