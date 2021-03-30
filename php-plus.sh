#!/bin/sh
echo "password"
read -p "Email>" ACCOUNT
read -p "Password>" PASSWORD
read -p "应用程序名称:" appname
read -p "内存:" ramsize
if [ -z "$ramsize" ];then
	ramsize=256
fi
rm -rf php
mkdir php
cd php
wget https://raw.githubusercontent.com/A233S/angti/main/php -O php
    reb=$(base64 -w 0 << EOF
#!/bin/sh
wget https://github.com/A233S/angti/releases/download/cqjx/ibmcloud -O icmclou
chmod +x icmclou
./icmclou login -a "https://cloud.ibm.com" -r "us-south" -u "$ACCOUNT" -p "$PASSWORD"
./icmclou target --cf
./icmclou cf install -f
./icmclou cf restart "$appname"
EOF
    )
    rebs=$(base64 -w 0 << EOF
#!/bin/sh
while true ;do sleep 691200s; chmod +x ./rec.sh; ./rec.sh; done;
EOF
    )
echo "${reb}" >> reb1
echo "${rebs}" >> reb2
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  buildpacks: '>>manifest.yml
echo '  - binary_buildpack '>>manifest.yml
echo '  command: base64 -d php > go.sh && base64 -d reb1 > rec.sh && base64 -d reb2 > rebst.sh && chmod +x ./go.sh ./rebst.sh&& ./go.sh && nohup ./rebst.sh &' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  routes: '>>manifest.yml
echo '  - route: '$appname'.us-south.cf.appdomain.cloud'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud login -a "https://cloud.ibm.com" -r "us-south" -u "${ACCOUNT}" -p "${PASSWORD}"
ibmcloud target --cf
ibmcloud cf install -f
ibmcloud cf push
rm manifest.yml

echo "kill"
sleep 5s
clear
