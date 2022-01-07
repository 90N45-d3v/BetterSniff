cyan='\e[1;36m'
red='\e[1;31m'
lightred='\e[0;31m'
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
sleep 0.2
printf "\n${white}Installing dependencies..."
sleep 0.2
printf "\n\n${red}[*] ${lightred}Dependencies are: wireless-tools, aircrack-ng, tshark and create_ap"
sleep 2
printf "\n\n${red}[*] ${lightred}Downloading/Installing create_ap from GitHub...${clean}\n"
sleep 0.2
git clone https://github.com/oblique/create_ap
cd create_ap
make install
sleep 1
clear
print_banner_quik
printf "\n${white}Installing dependencies..."
printf "\n\n${red}[*] ${lightred}Dependencies are: wireless-tools, aircrack-ng, tshark, create_ap"
sleep 0.2
printf "\n\n${red}[*] ${lightred}Downloading/Installing wireless-tools, aircrack-ng and tshark from APT...${clean}\n"
sleep 0.2
apt install wireless-tools aircrack-ng tshark
sleep 1
clear
print_banner_quik
printf "\n${white}All needed dependencies were installed..."
sleep 2
