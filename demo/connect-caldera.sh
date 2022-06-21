#!/bin/bash

# Start Caldera, and inform user of connection info
ipaddress=$(hostname --all-ip-addresses | awk '{print $2}')
web_port="8888"

echo "###########################################################"
echo "#                                                         #"
echo "#                                                         #"
echo "#                                                         #"
echo "#                                                         #"
echo "#   Connect to Caldera at http://${ipaddress}:${web_port}  "
echo "#                                                         #"
echo "#                                                         #"
echo "#                                                         #"
echo "#                                                         #"
echo "###########################################################"
