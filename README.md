# IP (TCP/UDP) reachability checker 
Bash script for checking the reachability of TCP and UDP ports on a specified IP address. 

The script allows users to specify the protocol (TCP or UDP), IP address, start port, and end port as command-line arguments. It relies on standard Unix utilities such as ping and timeout to perform the port checks.


#### terminal usage

```shell
curl https://raw.githubusercontent.com/shadoomedia/bash-ip-tcp-udp/main/check-ports.sh | bash -s <tcp/udp> <ip-address> <start-port> <end-port>
```
