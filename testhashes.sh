#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: ./testhashes.sh [good hash file] [test hash file]"
else
	orig=`cat $1`
	testerfile=$2
	testerhash=`openssl dgst -sha256 $testerfile | cut -d ' ' -f 2`
	if [ "$orig" = "$testerhash" ]
	then
		echo "Hashes match. File has not been modified"
	else
		echo "WARNING! File may have been modified!"
	fi
fi
