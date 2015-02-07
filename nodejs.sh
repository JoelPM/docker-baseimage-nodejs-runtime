#!/bin/sh
# `/sbin/setuser nodejs` runs the given command as the user `nodejs`.
# If you omit that part, the command will be run as root.
cd /home/nodejs/app && exec /sbin/setuser nodejs /usr/local/bin/npm start >>/var/log/nodejs.log 2>&1
