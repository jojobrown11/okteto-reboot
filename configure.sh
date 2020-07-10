#!/bin/sh
#显示时间
date
cat << EOF > /usr/local/etc/v2ray/config.json
{
  "inbounds": [
  {
    "port": 9090,
    "listen":"127.0.0.1",
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "56a91829-10b6-4150-9b46-fba1b3359d57",
          "alterId": 64       
        }
      ]
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {
      "path": "/ws"
      }     
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ]
}
EOF
# Run V2Ray
VERSION=$(/usr/local/bin/v2ray --version |grep V |awk '{print $2}')
REBOOTDATE=$(date)
sed -i "s/VERSION/$VERSION/g" /var/lib/nginx/html/index.html
sed -i "s/REBOOTDATE/$REBOOTDATE/g" /var/lib/nginx/html/index.html
nohup /usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json >v2.txt 2>&1 &
# start nginx
nginx
tail -f /dev/null
