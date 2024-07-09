#!/bin/bash

# Important: This script is intented to modify ONE 'allow' entry

first_arg=$1

if [ "$1" = "-h" ]; then
    echo "$name Pass nothing, to adapt the ip. Pass '-d' to remove the 'allow' entry."
    exit 0
fi

file="/etc/nginx/conf.d/www.your-page.foo.conf"
regexp='[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'
regexp_sed='[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}\.[[:digit:]]\{1,3\}'

name="[IP Adapt]:"

echo "${name} Start ..."

new_ip=$(w | grep -Eo $regexp | head -n 1)


if [ ! -f "$file" ]; then
        echo "${name} Error: File '$file' does not exist"
        exit 1
fi


if [ -z "$new_ip" ]; then
        echo "${name} Error: No IP found"
        exit 1
fi


cp "$file" "${file}.bak"


if [ "$1" = "-d" ]; then
    if ! grep -q "allow" "$file"; then
        echo "${name} No 'allow' found in file. Exiting"
        exit 0
    fi
    if grep -q '^#.*allow' "$file"; then
        echo "${name} Comment already present. Exiting"
        exit 0
    fi
    echo "${name} Comment the 'allow' line"
    sed -i '/allow/ s/^/#/' "$file"
else
    if grep -q '^#.*allow' "$file"; then
        sed -i '/^#.*allow/ s/^#//' "$file"
    fi
    echo "${name} Replacing ip with: ${new_ip}"
    sed -i "s/allow ${regexp_sed}/allow ${new_ip}/g" "$file"
fi


echo "${name} Reloading nginx ..."
nginx -s reload

echo "${name} Terminated"
exit 0

