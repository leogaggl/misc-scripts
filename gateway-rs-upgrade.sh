#!/bin/sh

killall -9 miner_run.sh
miner_script.sh stop
wget https://ursalink-resource-center.oss-us-west-1.aliyuncs.com/Support/kevin/helium-gateway-1.0.2
tar -xvf helium-gateway-1.0.2
./helium_gateway -c /root/settings.toml server &
