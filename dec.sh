#!/bin/bash

if [ $# -ne 4 ]
then
	echo "Usage: ./dec.sh [infile] [iv] [password] [outfile]"
else
	infile=$1
	iv=`cat $2`
	pass=$3
	outfile=$4
	
	`openssl enc -d -aes-256-cbc -a -in $infile -iv $iv -pass pass:$pass -out $outfile`
	if [ $? -eq 0 ]
	then
		echo "Successfully decrypted! Check $outfile"
	fi
fi
