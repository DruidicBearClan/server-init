This is my Ubuntu server initialization script

First it will generate the needed locales and set US and NL locales as default.

Then it will disable the local ntp daemon, install ntp and sync it to my own ntp server.

I will be adding more stuff in the future such as DNS etc.

This file mostly exists for me because I got tired of regenerating locales and adding my timeserver to my VM
