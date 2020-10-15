#!/bin/bash

#Instalação e setup do homeassistant em ambiente virtual python
apt-get update
apt-get upgrade -y
apt-get install python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev autoconf build-essential
useradd -rm homeassistant -G dialout,gpio,i2c
cd /srv
mkdir homeassistant
chown homeassistant:homeassistant homeassistant
-u homeassistant -H -s
cd /srv/homeassistant
python3 -m venv .
source bin/activate # <-aqui entramos em ambiente virtual Python
python3 -m pip install wheel
pip3 install homeassistant

exit

# Instalação do broker MQTT Mosquitto
sudo apt install -y mosquitto mosquitto-clients
sudo systemctl enable mosquitto.service

# Instalação do Zigbee2mqtt
sudo curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs git make g++ gcc
sudo git clone https://github.com/Koenkk/zigbee2mqtt.git /opt/zigbee2mqtt
sudo chown -R pi:pi /opt/zigbee2mqtt
cd /opt/zigbee2mqtt
npm ci
echo "\n\nadvanced:\n    network_key: GENERATE" >> /opt/zigbee2mqtt/data/configuration.yaml
echo z2mqtt_service.txt >> /etc/systemd/system/zigbee2mqtt.service
systemctl start zigbee2mqtt
sudo systemctl enable zigbee2mqtt.service
