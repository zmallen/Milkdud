#!/bin/bash

if [ $# -ne 4 ]
then
	echo "Usage: ./getemdown.sh [ipfile] [filetoget] [sshkey] [orighash]"
else
	ipfile=`cat $1`
	file=$2
	sshkey=$3
	orig=`cat $4`
	mkdir cloudpulls

	for ip in $ipfile; do
		knock -v $ip 7000 8000 9000
		`scp -i $sshkey ubuntu@$ip:~/$file cloudpulls/`
		if [ $? -eq 0 ]
		then
			echo "File pulled!"
			testerhash=`openssl dgst -sha256 cloudpulls/$file | cut -d ' ' -f 2`
			if [ "$orig" = "$testerhash" ]
			then
				echo "Hashes match to original hash!"
				exit $?
			else
				echo "WARNING! Hashes do not match. Deleting"
				rm cloudpulls/$file	
			fi
		fi
	done
	
fi
