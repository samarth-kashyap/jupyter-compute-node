#!/bin/bash

JUPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
nohup /mnt/disk2/samarth/Downloads/ngrok http 8879 &> /mnt/disk2/samarth/jupyter-compute-node/ngrok.log &
echo "Forwarding notebook to ngrok: samarth-kashyap"
taskset --cpu-list 0-2 jupyter lab >$JUPDIR/jupout 2>$JUPDIR/juperr &
echo "$!"
