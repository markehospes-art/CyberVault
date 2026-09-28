# 🌐 IP Addressing

IP addresses are unique identifiers for devices on a network. Understanding IPv4 and IPv6 is fundamental to networking and penetration testing.

## IPv4 Overview

### Address Structure
- **32-bit address** divided into 4 octets (bytes)
- **Format:** 192.168.1.1
- **Range:** 0.0.0.0 to 255.255.255.255
- **Total possible:** ~4.3 billion addresses

### Address Classes (Legacy)

| Class | First Octet | Subnet Mask | Range | Use |
|-------|-------------|-------------|-------|-----|
| A | 1-126 | 255.0.0.0 | 1.0.0.0 - 126.255.255.255 | Large networks |
| B | 128-191 | 255.255.0.0 | 128.0.0.0 - 191.255.255.255 | Medium networks |
| C | 192-223 | 255.255.255.0 | 192.0.0.0 - 223.255.255.255 | Small networks |
| D | 224-239 | N/A | 224.0.0.0 - 239.255.255.255 | Multicast |
| E | 240-255 | N/A | 240.0.0.0 - 255.255.255.255 | Reserved |

### Private IP Ranges (RFC 1918)

These addresses are **not routable on the internet** — used internally:

```
Class A:  10.0.0.0 - 10.255.255.255
Class B:  172.16.0.0 - 172.31.255.255
Class C:  192.168.0.0 - 192.168.255.255
```

### Special Addresses

| Address | Purpose |
|---------|----------|
| 0.0.0.0 | This network |
| 127.0.0.1 | Loopback (localhost) |
| 192.168.1.255 | Broadcast address |
| 255.255.255.255 | Limited broadcast |
| 169.254.x.x | Link-local (APIPA) |

### CIDR Notation

CIDR (Classless Inter-Domain Routing) specifies subnet mask as a prefix:

```
192.168.1.0/24
     ↑       ↑
   Network   /24 = 24 bits for network, 8 bits for hosts
```

**Common CIDR Ranges:**
- `/8` = 255.0.0.0 (16,777,216 hosts)
- `/16` = 255.255.0.0 (65,536 hosts)
- `/24` = 255.255.255.0 (256 hosts)
- `/25` = 255.255.255.128 (128 hosts)
- `/30` = 255.255.255.252 (4 hosts - good for point-to-point)
- `/32` = 255.255.255.255 (1 host - single IP)

### Calculating Addresses in a Subnet

For `192.168.1.0/24`:

```
Network Address:  192.168.1.0    (all host bits = 0)
First Usable:     192.168.1.1    (gateway)
Last Usable:      192.168.1.254  (last device)
Broadcast:        192.168.1.255  (all host bits = 1)
```

## IPv6 Overview

### Address Structure
- **128-bit address** written in hexadecimal
- **Format:** 2001:0db8:85a3:0000:0000:8a2e:0370:7334
- **Compressed:** 2001:db8:85a3::8a2e:370:7334
- **Total possible:** ~340 undecillion addresses

### Shortening IPv6 Addresses

**Rule 1:** Remove leading zeros in each segment
```
2001:0db8:0000:0000:0000:0000:0000:0001
→ 2001:db8:0:0:0:0:0:1
```

**Rule 2:** Consecutive zero segments → `::`
```
2001:db8:0:0:0:0:0:1
→ 2001:db8::1
```

⚠️ Only use `::` once per address!

### IPv6 Address Types

| Type | Range | Purpose |
|------|-------|----------|
| Global Unicast | 2000::/3 | Public internet |
| Link-Local | fe80::/10 | Local network only |
| Multicast | ff00::/8 | Multiple recipients |
| Loopback | ::1 | Localhost |
| Unspecified | :: | No address |

### IPv6 CIDR

Like IPv4:
```
2001:db8:85a3::/48 (network)
2001:db8:85a3::1/128 (single host)
```

## Subnetting Practice

### Example: Subnetting 192.168.1.0/24

**Question:** Create 4 subnets for 30 hosts each.

**Solution:**
```
Need: 30 hosts per subnet
Bits needed: log₂(30+2) = 5 bits for hosts
So: 3 bits for subnetting

Original: 192.168.1.0/24
New mask: /27 (24+3=27)

Subnet 1: 192.168.1.0/27    (0-31)     → .1 - .30
Subnet 2: 192.168.1.32/27   (32-63)    → .33 - .62
Subnet 3: 192.168.1.64/27   (64-95)    → .65 - .94
Subnet 4: 192.168.1.96/27   (96-127)   → .97 - .126
```

## Tools for IP Manipulation

```bash
# Display IP configuration
ip addr show          # Linux
ifconfig              # macOS/Linux (deprecated)
ipconfig              # Windows

# Test connectivity
ping 8.8.8.8
ping -c 4 8.8.8.8     # Linux/macOS (4 packets)

# DNS lookup
nslookup google.com
dig google.com        # Detailed DNS info
host google.com

# Trace route
traceroute google.com      # Linux/macOS
tracert google.com         # Windows

# Check routing table
ip route show         # Linux
route -n              # Linux
netstat -rn           # macOS/Linux

# ARP table (IP to MAC mapping)
arp -a                # All platforms
ip neigh              # Linux
```

## Security Implications

### Reconnaissance
- **IP enumeration:** Finding all IPs in a network
- **Geolocation:** Determining physical location from IP
- **WHOIS:** Finding IP owner information

### Attacks
- **IP spoofing:** Forging source IP address
- **ARP spoofing:** Mapping attacker MAC to victim IP
- **DHCP starvation:** Exhausting all IP addresses
- **Rogue DHCP:** Giving wrong IP configuration

### Defense
- **Static IPs:** For critical systems
- **IP filtering:** Firewall rules
- **DHCP snooping:** Prevent rogue DHCP servers
- **Dynamic DNS:** Keep hostnames updated

## IPv4 vs IPv6 Comparison

| Aspect | IPv4 | IPv6 |
|--------|------|------|
| Size | 32-bit | 128-bit |
| Format | Decimal (192.168.1.1) | Hex (2001:db8::1) |
| Addresses | ~4 billion | ~340 undecillion |
| Header size | 20 bytes | 40 bytes |
| DHCP | Required | Built-in (stateless) |
| NAT | Common | Not needed |
| Security | IPSec optional | IPSec required |
| Adoption | Universal | Growing |

## Common IP Ranges to Know

**Penetration Testing Targets:**
```
10.0.0.0/8        Private Class A (internal network)
172.16.0.0/12     Private Class B (internal network)
192.168.0.0/16    Private Class C (internal network)
```

**Cloud Providers:**
```
Google Cloud:    34.96.0.0/11
AWS:            54.0.0.0/8, 52.0.0.0/6
Azure:          13.64.0.0/11
```

## Related Resources

- [Subnetting](Subnetting.md) — Detailed subnetting techniques
- [OSI Model](OSI-Model.md) — Network layer (Layer 3)
- [Networking Fundamentals](README.md) — Back to overview

---

**Last Updated:** September 28, 2026