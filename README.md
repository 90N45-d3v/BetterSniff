![bettersniff_logo](https://user-images.githubusercontent.com/79598596/148476254-b03924ae-5baa-499b-9878-8fab1919d655.png)

With this script you can host an access point with [create_ap](https://github.com/oblique/create_ap) by [@oblique](https://github.com/oblique) and sniff all traffic with [Bettercap](https://www.bettercap.org/) automatically.
If you are connected to an existing network and want to sniff some traffic there, you can do that too.

## Features
- Sniff domains your victim is visiting (full path location if request is http)
- Inject customizable javascript into every http website
- Probe-request scanner (only rogue AP mode)
- Create configurable AP (only rogue AP mode)
- ARP-spoofing for beeing the mitm (only client mode)

## Installation
For me it works like a charm on kali (all needed tools are preinstalled), if you want to try running it on another linux distro, you maybe need to install some additional dependencies.
But now the installation guide:
```
git clone https://github.com/90N45-d3v/BetterSniff.git
cd BetterSniff
sudo chmod +x BetterSniff.sh
# and run it!
sudo bash BetterSniff.sh
```

## Working on...
- Channel configuration (only rogue AP mode)
- better overview for probe-request scanner
- deauth for more probe-requests (only rogue AP mode)
- Support for 5Ghz and/or 2.4Ghz

### Some information
I know, that this code could be better. 
If you have some improvements, errors or other things to say, just make a fork/pull-request or open an issue.
