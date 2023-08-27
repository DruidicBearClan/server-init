This is my Ubuntu server initialization script

It will generate some required locales, disable local systemd timesyncd service, install ntp package,
replace ntp.conf with the one from this project, and then configures the server as an ntp-client to the server specified inside the ntp.conf.

It will then go on to remove snap server packages and add my public key thumbprint to authorized_keys.

After that a cronjob is scheduled to run weekly updates.

This file mostly exists for my own server env, because I got tired of doing all the basic stuff over and over.