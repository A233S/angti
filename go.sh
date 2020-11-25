#!/bin/sh
curl -LO https://github.com/A233S/eaibm/raw/main/v2-ui.zip
unzip -o v2-ui.zip >> log.sh
rm -rf ./v2-ui.zip
cat << EOF > config.json
{
  "inbounds": [
    {
      "port": 8081,
      "listen": "127.0.0.1",
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "c79af876-4e53-4759-d564-5bcfe6bb4416",
            "alterId": 2
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/",
          "headers": {}
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
nohup ./v2-ui &
cd /tmp
curl -LO https://github.com/A233S/eaibm/raw/main/nginx.zip
unzip -o nginx.zip >> log.sh
chmod +x ./nginx/sbin/nginx
./nginx/sbin/nginx