#!/bin/bash

source .env

IP6=$(ip -6 addr show scope global | awk '/inet6/ {print $2}' | cut -d/ -f1)
echo $IP6

curl https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
  -X PATCH \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
  -d "{
    \"comment\": \"Update DNS record\",
    \"content\": \"$IP6\",
    \"name\": \"$DOMAIN_NAME\",
    \"ttl\": 1,
    \"proxied\": false,
    \"type\": \"AAAA\"
  }"

