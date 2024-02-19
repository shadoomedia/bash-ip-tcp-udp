#!/bin/bash

# Function to cleanup and exit
cleanup() {
    echo -e "\n____________________________"
    exit 0
}

# Trap Ctrl-C and call cleanup function
trap cleanup SIGINT

# Check if arguments are provided
if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <udp/tcp> <ip_address> <start_port> <end_port>"
    cleanup
fi

protocol=$(echo "$1" | tr '[:upper:]' '[:lower:]')
ip_address=$2
start_port=$3
end_port=$4

# Main loop for both UDP and TCP ports
echo " "
if [ "$protocol" == "udp" ]; then
    echo "## Checking $ip_address (UDP) ##"
    echo "---------"
elif [ "$protocol" == "tcp" ]; then
    echo "## Checking $ip_address (TCP) ##"
    echo "---------"
else
    echo "Invalid protocol specified. Please choose 'udp' or 'tcp'."
    cleanup
fi

if ping -c 1 -W 1 $ip_address &> /dev/null; then
    for ((port=start_port; port<=end_port; port++)); do
        if [ "$protocol" == "udp" ]; then
            if timeout 1 bash -c "echo >/dev/udp/$ip_address/$port" &> /dev/null; then
                echo -e "Port $port (UDP) is \033[32m reachable\033[0m \xE2\x9C\x94"
                echo "-"
            fi
        elif [ "$protocol" == "tcp" ]; then
            if timeout 1 bash -c "echo >/dev/tcp/$ip_address/$port" &> /dev/null; then
                echo -e "Port $port (TCP) is \033[32m reachable\033[0m \xE2\x9C\x94"
                echo "-"
            fi
        fi
    done
else
    echo "Can't connect to $ip_address"
fi

# Cleanup at the end of the script
cleanup
