cd /tmp
curl https://github.com/dutchcoders/transfer.sh/releases/download/v1.6.0/transfersh-v1.6.0-linux-amd64 > transfersh
chmod 777 transfersh
nohup ./transfersh --provider=local --listener :8080 --temp-path=/tmp/ --basedir=/tmp/ > /dev/null &
