#!/bin/bash

file="/etc/nginx/conf.d/www.your-page.foo.conf"
regexp='[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'
regexp_sed='[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}'

name="[IP Adapt]:"

echo "$name Start ..."

new_ip=$(w | grep -Eo $regexp | head -n 1)

if [ ! -f "$file" ]; then
        echo "$name File '$file' does not exist"
        exit 1
fi

if [ -z "$new_ip" ]; then
        echo "$name No IP found"
        exit 1
fi

sed -i.bak "s/allow ${regexp_sed}/allow ${new_ip}/g" "$file"
nginx -s reload
echo "$name Terminated"
exit 0
