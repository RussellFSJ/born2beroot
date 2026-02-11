#!/bin/bash

# architecture of os and kernel version
architecture=$(uname -a)

# physical processor(s)
no_of_physical_processors=$(grep "physical id" /proc/cpuinfo | wc -l)

# virtual processor(s) 
no_of_virutal_processors=$(grep "processor" /proc/cpuinfo | wc -l)

# ram
ram_total=$(free --mega | awk '$1 == "Mem:" {print $2}')
ram_use=$(free --mega | awk '$1 == "Mem:" {print $3}')
ram_percent=$(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

# disk 
disk_total=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{use += $3} {total += $2} END {printf("(%d%%)\n"), use/total*100}')
disk_use=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}')
disk_percent=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} {disk_t+= $2} END {printf("%d"), disk_u/disk_t*100}')

# cpu 
cpul=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_op=$(expr 100 - $cpul)
cpu_load=$(printf "%.1f" $cpu_op)

# date and time of last boot 
last_boot=$(who -b | awk '$1 == "system" {print $3 " " $4}')

# lvm active?
lvm_active=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)

# tcp connection(s)
tcp_connections=$(ss -ta | grep ESTAB | wc -l)

# user(s)
ulog=$(users | wc -w)

# ipv4 address
ip_addr=$(hostname -I)

# mac address
mac_addr=$(ip link | grep "link/ether" | awk '{print $2}')

# sudo command(s)
commands=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "
Architecture     : $architecture
CPU physical     : $no_of_physical_processors
vCPU             : $no_of_virutal_processors
Memory Usage     : $ram_use/${ram_total}MB ($ram_percent%)
Disk Usage       : $disk_use/${disk_total} ($disk_percent%)
CPU load         : $cpu_load%
Last boot        : $last_boot
LVM use          : $lvm_active
Connections TCP  : $tcp_connections ESTABLISHED
User log         : $ulog
Network          : IP $ip_addr ($mac_addr)
Sudo             : $commands cmd
"
