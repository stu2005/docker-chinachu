#!/bin/bash
chown node:node config.json rules.json 
cd data
chown node:node recorded.json  recording.json  reserves.json  schedule.json  scheduler.pid
cd ..

rm -f /var/run/chinachu-operator.pid > /dev/null 2>&1
rm -f /var/run/chinachu-wui.pid > /dev/null 2>&1

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
