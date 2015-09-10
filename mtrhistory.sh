#!/bin/bash
for probe in $(cat probes); do
        date=$(date +'%Y-%m-%d-%H%M')
        rhost=$(echo $probe | sed -e 's/,/ /' | awk '{ print $1}')
        ruser=$(echo $probe | sed -e 's/,/ /' | awk '{ print $2}')
        mkdir /smokeping/mtrhistory/$rhost
        mkdir /smokeping/mtrhistory/$rhost/$date
        for target in $(cat targets); do
                echo "MTR $target from $rhost at $(date)"
                ssh -l $ruser $rhost 'mtr --report -w' $target '| grep -v "HOST:"' >/smokeping/mtrhistory/$rhost/$date/$target.dns
                ssh -l $ruser $rhost 'mtr --report --no-dns -w' $target '| grep -v "HOST:"' >/smokeping/mtrhistory/$rhost/$date/$target.nodns
        done
done
