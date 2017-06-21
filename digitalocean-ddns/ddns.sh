#!/bin/sh
if [ -z $DIGITALOCEAN_TOKEN ]; then
    echo "DIGITALOCEAN DDNS: DIGITALOCEAN_TOKEN is not set" >&2
    exit 1
fi
if [ -z $DOMAIN ]; then
    echo "DIGITALOCEAN DDNS: DOMAIN is not set" >&2
    exit 1
fi
if [ -z $RECORD ]; then
    echo "DIGITALOCEAN DDNS: RECORD is not set" >&2
    exit 1
fi

IP_FILE=/etc/public_ip
RECORDS_API=https://api.digitalocean.com/v2/domains/$DOMAIN/records
PUBLIC_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "DIGITALOCEAN DDNS: IP address is $PUBLIC_IP"

if [ -f $IP_FILE ]; then
    PREVIOUS_IP=$(<$IP_FILE)

    if [ $PUBLIC_IP = $PREVIOUS_IP ]; then
        echo "DIGITALOCEAN DDNS: IP address unchanged"
        exit
    fi
fi

echo "DIGITALOCEAN DDNS: IP address changed"
echo $PUBLIC_IP > $IP_FILE

RECORD_ID=$(curl -s -X GET \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
    $RECORDS_API | jq ".domain_records[] | select(.name == \"$RECORD\") | .id")
PAYLOAD='{"type":"A","name":"'$RECORD'","data":"'$PUBLIC_IP'"}'

if [ -z $RECORD_ID ]; then
    echo "DIGITALOCEAN DDNS: Existing DNS record not found, creating a new one"

    curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
        -d $PAYLOAD \
        $RECORDS_API > /dev/null
else
    echo "DIGITALOCEAN DDNS: Updating existing DNS record id $RECORD_ID"

    # curl -s -X PUT \
    #     -H "Content-Type: application/json" \
    #     -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
    #     -d $PAYLOAD \
    #     $RECORDS_API/$RECORD_ID > /dev/null
fi
