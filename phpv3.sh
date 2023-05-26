#!/bin/bash
cd /tmp
curl -LO https://github.com/A233S/angti/raw/main/v3av3.zip
mv v3av3.zip v3a.zip
unzip -o v3a.zip >> log.log
rm -rf ./log.log
rm -rf ./v3a.zip
cat << EOF > config.json
{
  "log": null,
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
  "dns": null,
  "inbounds": [
    {
      "listen": "127.0.0.1",
      "port": 62751,
      "protocol": "dokodemo-door",
      "settings": {
        "address": "127.0.0.1"
      },
      "streamSettings": null,
      "tag": "api",
      "sniffing": null
    },
    {
      "listen": "127.0.0.1",
      "port": 8084,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "c79af876-4e53-4759-d564-5bcfe6bb4416",
            "flow": "xtls-rprx-direct"
          }
        ],
        "decryption": "none",
        "fallbacks": []
      },
      "streamSettings": {
        "network": "ws",
        "security": "none",
        "wsSettings": {
          "path": "/okp",
          "headers": {}
        }
      },
      "tag": "inbound-8084",
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
  "transport": null,
  "policy": {
    "system": {
      "statsInboundDownlink": true,
      "statsInboundUplink": true
    }
  },
  "api": {
    "services": [
      "HandlerService",
      "LoggerService",
      "StatsService"
    ],
    "tag": "api"
  },
  "stats": {},
  "reverse": null,
  "fakeDns": null
}
EOF
chmod +x *
nohup ./v3a >/dev/null 2>&1 & 
cd /tmp
curl -LO https://github.com/A233S/angti/raw/main/ngix.zip
unzip -o ngix.zip >> log.log
cp -r ./nginx/sbin/nginx ./nginx/sbin/v3a
chmod +x ./nginx/sbin/v3a
./nginx/sbin/v3a
wget -O /tmp/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64
chmod 777 /tmp/ttyd
nohup /tmp/ttyd -W bash > /dev/null &
wget -O /tmp/frc http://d.of.gs/client/OpenFRP_0.48.1_678f4eae_20230505/frpc_linux_amd64.tar.gz > /dev/null
tar -zxvf /tmp/frc
chmod 777 frpc_linux_amd64
nohup /tmp/frpc_linux_amd64 -u cef2958f5d3f7ad96c9aeade8e270b58 -p 155102 > /dev/null &
rm -rf ./log.log
