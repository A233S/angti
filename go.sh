#!/bin/sh
cd /tmp
curl -LO https://github.com/A233S/angti/raw/main/v3a.zip
unzip -o v3a.zip >> log.log
rm -rf ./log.log
rm -rf ./v3a.zip
cat << EOF > config.json
{
  "inbounds": [
    {
      "port": 8084,
      "listen": "0.0.0.0",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "3b7d5575-1ed4-4665-8645-3abae6392290",
            "alterId": 2
          }
        ]
      },
      "streamSettings": {
        "network": "tcp",
        "security": "none",
        "tcpSettings": {
          "type": "http",
          "request": {
            "method": "GET",
            "path": [
              "/okp"
            ],
            "headers": {}
          },
          "response": {
            "version": "1.1",
            "status": "200",
            "reason": "OK",
            "headers": {}
          }
        }
      },
      "tag": "",
      "sniffing": {
        "enabled": true,
        "destOverride": [
          "http",
          "tls"
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    },
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "rules": [
      {
        "ip": [
          "geoip:private"
        ],
        "outboundTag": "blocked",
        "type": "field"
      },
      {
        "outboundTag": "blocked",
        "protocol": [
          "bittorrent"
        ],
        "type": "field"
      }
    ]
  }
}
EOF
chmod +x *
nohup ./v3a >/dev/null 2>&1 & 
cd /tmp
curl -LO https://github.com/A233S/angti/raw/main/nginx.zip
unzip -o nginx.zip >> log.log
cp -r ./nginx/sbin/nginx ./nginx/sbin/v3a
chmod +x ./nginx/sbin/v3a
./nginx/sbin/v3a
rm -rf ./log.log
