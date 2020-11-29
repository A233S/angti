#!/bin/sh
echo "这里需要输入IBM登录的帐号和密码，以供自动选择API端点所使用。"
read -p "Email>" ACCOUNT
read -p "Password>" PASSWORD
read -p "请输入您的应用程序名称:" appname
read -p "请设置您的容器内存大小(默认256):" ramsize
if [ -z "$ramsize" ];then
	ramsize=256
fi
rm -rf phpcf
mkdir phpcf
cd phpcf
wget https://raw.githubusercontent.com/A233S/eaibm/main/php-vlss -O php
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  buildpacks: '>>manifest.yml
echo '  - binary_buildpack '>>manifest.yml
echo '  command: base64 -d php > go.sh && chmod +x ./go.sh && ./go.sh' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  routes: '>>manifest.yml
echo '  - route: '$appname'.us-south.cf.appdomain.cloud'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
ibmcloud login -a "https://cloud.ibm.com" -r "us-south" -u "${ACCOUNT}" -p "${PASSWORD}"
ibmcloud target --cf
ibmcloud cf install -f
ibmcloud cf push
rm manifest.yml
ibmyuming=$appname.us-south.cf.appdomain.cloud
    VMESSCODE=$(base64 -w 0 << EOF
    {
      "v": "2",
      "ps": "IBM",
      "add": "$ibmyuming",
      "port": "443",
      "id": "c79af876-4e53-4759-d564-5bcfe6bb4416",
      "aid": "2",
      "net": "ws",
      "type": "none",
      "host": "",
      "path": "/openvmkss",
      "tls": "tls"
    }
EOF
    )
	echo "您的客户端配置链接："
    echo vmess://${VMESSCODE}

echo "请在45秒内保存您的客户端配置链接"
sleep 45s
clear
