#! /usr/bin/env bash

echo "get NGIC images which are SPGW-C and SPGW-U"
docker login
docker pull woojoong/kone-cp
docker pull woojoong/kone-dp

echo "make networks"
docker network create --driver=bridge --subnet=192.168.103.0/24 --ip-range=192.168.103.0/24 --gateway=192.168.103.254 brs11
docker network create --driver=bridge --subnet=192.168.104.0/24 --ip-range=192.168.104.0/24 --gateway=192.168.104.254 brspgw
docker network create --driver=bridge --subnet=192.168.105.0/24 --ip-range=192.168.105.0/24 --gateway=192.168.105.254 brs1u
docker network create --driver=bridge --subnet=192.168.106.0/24 --ip-range=192.168.106.0/24 --gateway=192.168.106.254 brsgi

echo "run Docker images"
docker run -t -d --name cp -v $(pwd)/config:/opt/ngic/config woojoong/kone-cp:latest bash
docker network connect brs11 cp
docker network connect brspgw cp

docker run -t -d --name dp --cap-add IPC_LOCK --cap-add NET_ADMIN -v $(pwd)/config:/opt/ngic/config woojoong/kone-dp:latest bash
docker network connect brs1u dp
docker network connect brsgi dp
docker network connect brspgw dp
