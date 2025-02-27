#!/bin/bash


API_KEY="APIKEYHERE"  # AbuseIPDB API KEY
IP_TO_CHECK=$1

if [ -z "$IP_TO_CHECK" ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

response=$(curl -s -G https://api.abuseipdb.com/api/v2/check \
  --data-urlencode "ipAddress=$IP_TO_CHECK" \
  --data-urlencode "maxAgeInDays=90" \
  -H "Key: $API_KEY" \
  -H "Accept: application/json")

score=$(echo "$response" | jq '.data.abuseConfidenceScore')
usageType=$(echo "$response" | jq -r '.data.usageType')
country=$(echo "$response" | jq -r '.data.countryName')

echo "IP: $IP_TO_CHECK"
echo "Abuse Confidence Score: $score"
echo "Usage Type: $usageType"
echo "Country: $country"

