#!/bin/sh                                                                                         

#
# Milesight U65H update local_conf.json forwareder configuration files to AU915 FSB2
#

while ! jsonpath -i /etc/quagga/lora/local_conf.json -e '$.gateway_conf.servers[1].serv_enabled'; do
    echo "not enable"
    sleep 60
done

LORWAN_REGION_CODE="AU915"

echo $LORWAN_REGION_CODE >> /etc/urlog/test.log

radio_0_freq=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.radio_0.freq'`
radio_0_freq_min=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.radio_0.tx_freq_min'`
radio_0_freq_max=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.radio_0.tx_freq_max'`
radio_1_freq=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.radio_1.freq'`
chan_0=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_0.if'`
chan_1=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_1.if'`
chan_2=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_2.if'`
chan_3=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_3.if'`
chan_4=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_4.if'`
chan_5=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_5.if'`
chan_6=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_6.if'`
chan_7=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_7.if'`
radio_0=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_0.radio'`
radio_1=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_1.radio'`
radio_2=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_2.radio'`
radio_3=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_3.radio'`
radio_4=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_4.radio'`
radio_5=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_5.radio'`
radio_6=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_6.radio'`
radio_7=`jsonpath -i /etc/quagga/lora/helium_conf.json.$LORWAN_REGION_CODE -e '$.SX130x_conf.chan_multiSF_7.radio'`

sed -i ':a;N;$!ba;s/\("freq": \)\S*/\"freq": '"${radio_0_freq},"'/1' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("tx_freq_min": \)\S*/\"tx_freq_min": '"${radio_0_freq_min},"'/1' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("tx_freq_max": \)\S*/\"tx_freq_max": '"${radio_0_freq_max},"'/1' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("freq": \)\S*/\"freq": '"${radio_1_freq},"'/2' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_0}"'/1' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_1}"'/2' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_2}"'/3' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_3}"'/4' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_4}"'/5' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_5}"'/6' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_6}"'/7' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("if": \)\S*/\"if": '"${chan_7}"'/8' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_0},"'/1' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_1},"'/2' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_2},"'/3' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_3},"'/4' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_4},"'/5' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_5},"'/6' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_6},"'/7' /etc/quagga/lora/local_conf.json
sed -i ':a;N;$!ba;s/\("radio": \)\S*/\"radio": '"${radio_7},"'/8' /etc/quagga/lora/local_conf.json

/etc/init.d/lora_pkt_fwd restart
