#!/bin/bash

echo "Content-type: application/json"
echo ""
ls /mnt | jq -R -s -c 'split("\n")[:-1]'
