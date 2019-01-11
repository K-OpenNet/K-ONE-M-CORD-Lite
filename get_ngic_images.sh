#! /usr/bin/env bash

echo "get NGIC images which are SPGW-C and SPGW-U"
docker login
docker pull woojoong/kone-cp
docker pull woojoong/kone-dp
