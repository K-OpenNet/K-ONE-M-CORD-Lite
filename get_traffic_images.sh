#! /usr/bin/env bash
docker login
docker pull woojoong/kone-traffic-gen:latest

docker run -t -d --name traffic --cap-add NET_ADMIN -v $(pwd)/pcap:/opt/ngic/pcap woojoong/kone-traffic-gen bash
docker network connect brs11 traffic
docker network connect brs1u traffic
docker network connect brsgi traffic

