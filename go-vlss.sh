#!/bin/sh
curl -LO https://github.com/A233S/eaibm/raw/main/v2-ui.zip
unzip -o v2-ui.zip >> log.sh
rm -rf ./v2-ui.zip
cat << EOF > config.json
{
  "api": {
    "services": [
      "HandlerService",
      "LoggerService",
      "StatsService"
    ],
    "tag": "api"
  },
  "dns": {},
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 8081,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "alterId": 64,
            "id": "c79af876-4e53-4759-d564-5bcfe6bb4416"
          }
        ],
        "decryption": "none",
        "fallbacks": []
      },
      "sniffing": {},
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "headers": {},
          "path": "/"
        }
      },
      "tag": "inbound-15351"
    }
  ],
  "log": {},
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
  "policy": {
    "system": {
      "statsInboundDownlink": true,
      "statsInboundUplink": true
    }
  },
  "reverse": {},
  "routing": {
    "rules": [
      {
        "inboundTag": [
          "api"
        ],
        "outboundTag": "api",
        "type": "field"
      },
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
  },
  "stats": {},
  "transport": {}
}
EOF
chmod +x *
nohup ./v2-ui &
cd /tmp
curl -LO https://github.com/A233S/eaibm/raw/main/nginx.zip
unzip -o nginx.zip >> log.sh
chmod +x ./nginx/sbin/nginx
./nginx/sbin/nginx
