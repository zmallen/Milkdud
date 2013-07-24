#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Usage: ./putemup.sh [ipfile] [filetosend] [sshkey]"
else
	ips=`cat $1`
	file=$2
	sshkey=$3
	for ip in $ips; do
		knock -v $ip 7000 8000 9000
		`scp -i $sshkey $file ubuntu@$ip:~/`
		if [ $? -eq 0 ]
		then
			echo "file send success @ $ip"
		fi
	done
fi
