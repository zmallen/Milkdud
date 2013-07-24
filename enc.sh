#!/bin/bash

if [ $# -ne 3 ]
then
	echo "Usage: ./enc.sh [infile] [password] [outfile]"
else
	# for a "true" random IV, use /dev/random , this will block code until
	# enough entropy is generated for Linux to perform the translate
	# operation
	iv=`cat /dev/urandom | tr -cd 'A-F0-9' | head -c 32`
	infile=$1
	pass=$2
	outfile=$3
	`openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile -pass pass:$pass -iv $iv`
	if [ $? -eq 0 ] 
	then
		echo "Success! File $outfile created"
		echo "iv stored in: $outfile.iv"
		echo "hash of enc file stored in: $outfile.hash"
		echo $iv > "$outfile.iv"
		hash=`openssl dgst -sha256 $outfile | cut -d ' ' -f 2`
		echo $hash > "$outfile.hash"
	else
		echo "Epic Fail!"
	fi
	
fi
