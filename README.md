This is my Ubuntu server initialization script

First it will generate the needed locales and set US and NL locales as default.

Then it will disable the local ntp daemon, install ntp and sync it to my own ntp server.

I will be adding more stuff in the future such as DNS etc.

This file mostly exists for my own server env, because I got tired of regenerating locales and 
changing around my ntp config for each server I install, but I don't have enough machines for ansible or saltstack.
