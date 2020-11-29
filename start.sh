#!/bin/sh
read -p "请输入您的应用程序名称:" appname
read -p "请设置您的容器内存大小(默认256):" ramsize
if [ -z "$ramsize" ];then
	ramsize=256
fi
rm -rf phpcf
mkdir phpcf
cd phpcf
wget https://raw.githubusercontent.com/A233S/eaibm/main/php -O php
echo 'applications:'>>manifest.yml
echo '- path: .'>>manifest.yml
echo '  buildpacks: '>>manifest.yml
echo '  - binary_buildpack '>>manifest.yml
echo '  command: base64 -d php > go.sh && chmod +x ./go.sh && ./go.sh' >>manifest.yml
echo '  name: '$appname''>>manifest.yml
echo '  routes: '>>manifest.yml
echo '  - route: '$appname'.us-south.cf.appdomain.cloud'>>manifest.yml
echo '  memory: '$ramsize'M'>>manifest.yml
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

echo
echo "Welcome to IBM Cloud Shell!"
echo "Image version: 1.0.10"
echo "Help us improve future releases by clicking Feedback to share your experience!"
echo "Note: Your Cloud Shell session is running in Dallas (us-south). Your workspace includes 500 MB of temporary storage. This session will close after an hour of inactivity. If you don't have any active sessions for an hour or you reach the 50-hour weekly usage limit, your workspace data is removed. To track your usage, go to Usage quota in the Cloud Shell menu."
echo "Tip: Enter 'ibmcloud' to use the IBM Cloud CLI. The Dallas (us-south) region is targeted by default. You can switch the region by running 'ibmcloud target -r <region-name>'."
echo
