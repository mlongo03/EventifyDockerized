#!/bin/bash

awk -v prot="$SERVER_PROT" -v ip="$SERVER_IP" -v port="$SERVER_PORT" '{ gsub(/<PROT>:\/\/<IP>:<PORT>/, prot "://" ip ":" port); print }' "./src/app/axios.service.ts" > tmp.txt && cat tmp.txt > ./src/app/axios.service.ts

awk -v prot="$SERVER_PROT" -v ip="$SERVER_IP" -v port="$SERVER_PORT" '{ gsub(/<PROT>:\/\/<IP>:<PORT>/, prot "://" ip ":" port); print }' "./src/app/SseService.ts" > tmp.txt && cat tmp.txt > ./src/app/SseService.ts && rm tmp.txt

