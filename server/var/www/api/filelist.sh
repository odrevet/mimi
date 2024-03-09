#!/bin/bash

source decode-params.sh

echo "Content-type: application/json"
echo ""
ls /mnt/${params['path']} | jq -R -s -c 'split("\n")[:-1]'
