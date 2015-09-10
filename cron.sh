#!/bin/bash
cat /etc/smokeping/targetgen | grep 'host =' | awk '{print $3}' >/root/mtrhistory/targets
bash mthistory.sh >>/var/log/mtrhistory
