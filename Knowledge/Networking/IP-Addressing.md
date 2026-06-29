# IP Addressing

## Overview
IP (Internet Protocol) addresses are unique numerical labels assigned to devices on a network. They enable routing and delivery of data packets across networks.

## IPv4 Addressing

### Format
- **32 bits** divided into 4 octets (bytes)
- **Decimal notation**: 192.168.1.1
- **Range**: 0.0.0.0 to 255.255.255.255
- **Total addresses**: ~4.3 billion

### Example Breakdown
```
192.168.1.1
│   │   │ └─ Host ID (0-255)
│   │   └──── Third octet (0-255)
│   └──────── Second octet (0-255)
└──────────── First octet (0-255)
```

## IP Address Classes (Classful)

### Class A
- **Range**: 1.0.0.0 to 126.255.255.255
- **Default Mask**: 255.0.0.0 (/8)
- **Networks**: 128 networks
- **Hosts per network**: 16,777,214
- **Use**: Large organizations

### Class B
- **Range**: 128.0.0.0 to 191.255.255.255
- **Default Mask**: 255.255.0.0 (/16)
- **Networks**: 16,384 networks
- **Hosts per network**: 65,534
- **Use**: Medium organizations

### Class C
- **Range**: 192.0.0.0 to 223.255.255.255
- **Default Mask**: 255.255.255.0 (/24)
- **Networks**: 2,097,152 networks
- **Hosts per network**: 254
- **Use**: Small businesses, home networks

### Class D
- **Range**: 224.0.0.0 to 239.255.255.255
- **Use**: Multicast (one-to-many)

### Class E
- **Range**: 240.0.0.0 to 255.255.255.255
- **Use**: Reserved (experimental)

## Private IP Address Ranges (RFC 1918)

Reserved for internal use, not routable on public internet:

| Class | Private Range | Mask |
|-------|---------------|------|
| A | 10.0.0.0 - 10.255.255.255 | 10.0.0.0/8 |
| B | 172.16.0.0 - 172.31.255.255 | 172.16.0.0/12 |
| C | 192.168.0.0 - 192.168.255.255 | 192.168.0.0/16 |

## Special IP Addresses

| Address | Purpose |
|---------|----------|
| 0.0.0.0 | "This network" |
| 127.0.0.1 | Loopback (localhost) |
| 127.x.x.x | Loopback range |
| 255.255.255.255 | Broadcast |
| x.x.x.0 | Network address |
| x.x.x.255 | Broadcast address |

## Subnet Mask

### Purpose
Determines which part of IP is network and which is host.

### Example
```
IP Address:    192.168.1.100
Subnet Mask:   255.255.255.0
               (first 3 octets = network)
               (last octet = host)

Network: 192.168.1.0
Host: 100
```

### Mask Notation
- **Decimal**: 255.255.255.0
- **CIDR**: /24 (24 bits for network)

## IPv6 Addressing

### Format
- **128 bits** (vs 32 for IPv4)
- **Hexadecimal notation**: 2001:0db8:85a3:0000:0000:8a2e:0370:7334
- **Shortened**: 2001:db8:85a3::8a2e:370:7334
- **Total addresses**: 340 undecillion (~340×10³⁶)

### Advantages Over IPv4
- ✅ Virtually unlimited addresses
- ✅ Simpler routing
- ✅ Built-in security (IPsec)
- ✅ Better multicast support

## IP Address Assignments

### Static IP
- Manually assigned
- Doesn't change
- Good for: servers, printers, routers

### Dynamic IP (DHCP)
- Automatically assigned by DHCP server
- Temporary (leased)
- Good for: workstations, mobile devices

## Common Commands (Educational)

### Check your IP (Windows)
```bash
ipconfig
```

### Check your IP (Linux/Mac)
```bash
ifconfig
ip addr
```

### Check specific device
```bash
arp -a          # Show IP to MAC mapping
ping 8.8.8.8    # Test connectivity
```

## Key Concepts

- IPv4 addresses uniquely identify devices
- Subnet masks determine network boundaries
- Private IPs for internal networks, public IPs for internet
- IPv6 is future standard with massive address space
- DHCP automates IP assignment