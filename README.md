![154769341-1c379aeb-c39e-4c53-9344-8ef8c85b7b92](https://user-images.githubusercontent.com/79598596/170995029-e96197f6-2381-4908-b050-c3dfd778e34c.svg)

<p align="center">
  <img src="https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg">
  <img src="https://img.shields.io/github/license/90N45-d3v/BetterSniff.svg">
  <img src="https://img.shields.io/badge/Made%20with-Bash-1f425f.svg">
</p>

With this script you can host an access point with [create_ap](https://github.com/oblique/create_ap) by [@oblique](https://github.com/oblique) and sniff all traffic with [Bettercap](https://www.bettercap.org/) automatically.
If you are connected to an existing network and want to sniff some traffic there, you can do that too.

## Features
- Sniff domains your victim is visiting/pinging (full path location if request is not encrypted with SSL/TLS)
- Sniff unencrypted credentials from sources like telnet, SMTP or FTP
- Inject customizable javascript into every http website
- Sniffed traffic will be logged for later analysis
- Probe-request scanner (only rogue AP mode)
- Create configurable AP (only rogue AP mode)
- ARP-spoofing for beeing the mitm (only client mode)

## Installation
For me it works like a charm on kali (all needed tools are preinstalled). If you want to run it for example on a raspberry pi with a debian based system, it should work too.
Now the installation guide:
```
git clone https://github.com/90N45-d3v/BetterSniff.git
cd BetterSniff
sudo bash requirements.sh
# and run it!
sudo bash BetterSniff.sh
```

## Analyze your traffic later
If you sniffed some traffic with BetterSniff once, there will be a loot file (loot.pcap) for later analysis.
You can take a look at the sniffed traffic with following commands:
```
# start bettercap
sudo bettercap
# set loot.pcap as source for net.sniff
set net.sniff.source loot.pcap
# take a look at it
net.sniff on
```

## Working on...
- New mode: EvilTwin (clone existing WPA2-AP)
- Settings for easily handling the mapping of domains to a custom IP address ([Bettercap's DNS spoofer](https://www.bettercap.org/modules/ethernet/spoofers/dns.spoof/))
- deauth for more probe-requests (only rogue AP mode)

### Some information
I know, that this code could be better. 
If you have some improvements, errors or other things to say, just make a fork, pull-request, open an issue or contact me on twitter [@90N45](https://twitter.com/90N45).
