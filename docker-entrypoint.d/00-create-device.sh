#!/bin/bash

set -xe

# Generate certificates
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj '/CN=localhost'

CERT=$(sed 's/$/\\n/' cert.pem | tr -d '\n' | sed 's!\\!\\\\!g')
KEY=$(sed 's/$/\\n/' key.pem | tr -d '\n' | sed 's!\\!\\\\!g')
# Get Thumbprint
THUMBPRINT=$(openssl x509 -in cert.pem -fingerprint -noout | cut -d '=' -f 2)

# Registrate device at Eugenio
ID=$(curl -X POST "https://portal.stg.eugenio.io/api/v1/things" -H "Content-Type: application/json" -H "apikey: $APIKEY" --data "{\"thumbprint\": \"$THUMBPRINT\", \"tags\": {\"deviceName\": \"nodered-$RANDOM\"}}" | jq '.deviceId' | tr -d '"')

echo "id ---- $ID"

# Configure Node-red files
sed -i "s@{deviceId}@$ID@g" /data/flows.json
sed -i "s@{deviceId}@$ID@g" /data/flows_cred.json
sed -i "s@{cert}@$CERT@g" /data/flows_cred.json
sed -i "s@{key}@$KEY@g" /data/flows_cred.json
