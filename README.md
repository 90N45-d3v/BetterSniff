![bettersniff-banner1536px](https://user-images.githubusercontent.com/79598596/154769341-1c379aeb-c39e-4c53-9344-8ef8c85b7b92.png)
<p align="center">
  <img src="https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg">
  <img src="https://img.shields.io/github/license/90N45-d3v/BetterSniff.svg">
  <img src="https://img.shields.io/badge/Made%20with-Bash-1f425f.svg">
</p>

With this script you can host an access point with [create_ap](https://github.com/oblique/create_ap) by [@oblique](https://github.com/oblique) and sniff all traffic with [Bettercap](https://www.bettercap.org/) automatically.
If you are connected to an existing network and want to sniff some traffic there, you can do that too.

## Features
- Sniff domains your victim is visiting (full path location if request is http)
- Inject customizable javascript into every http website
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

## Working on...
- New mode: EvilTwin (clone existing WPA2-AP)
- Log-file from sniffed traffic till next usage
- deauth for more probe-requests (only rogue AP mode)

### Some information
I know, that this code could be better. 
If you have some improvements, errors or other things to say, just make a fork/pull-request or open an issue.
