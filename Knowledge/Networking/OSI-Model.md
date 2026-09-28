# 🌐 The OSI Model

The Open Systems Interconnection (OSI) model is a 7-layer framework that describes how network communication works. Understanding it is essential for networking and security troubleshooting.

## Overview

| Layer | Name | Function | Examples |
|-------|------|----------|----------|
| 7 | Application | User applications & services | HTTP, SMTP, DNS, SSH |
| 6 | Presentation | Data formatting & encryption | SSL/TLS, JPEG, MP4 |
| 5 | Session | Connection management | RPC, NetBIOS |
| 4 | Transport | End-to-end communication | TCP, UDP |
| 3 | Network | Routing & IP addressing | IP, ICMP, BGP |
| 2 | Data Link | MAC addressing & switching | Ethernet, ARP, 802.11 |
| 1 | Physical | Cables, signals, voltage | Fiber, Copper, Radio |

## Layer Breakdown

### Layer 7: Application
**What it does:** Where users interact with network services.

**Key Protocols:**
- **HTTP/HTTPS** — Web browsing
- **FTP/SFTP** — File transfer
- **DNS** — Domain name resolution
- **SMTP/POP3/IMAP** — Email
- **SSH** — Secure shell access
- **Telnet** — Remote login (unencrypted ⚠️)

**Security Concerns:**
- SQL injection (targeting databases)
- Cross-site scripting (XSS)
- API vulnerabilities
- Weak authentication

### Layer 6: Presentation
**What it does:** Formats, encrypts, and compresses data before transmission.

**Functions:**
- Data formatting (ASCII, Unicode)
- Encryption/decryption
- Compression (ZIP, GZIP)
- Character set conversion

**Examples:**
- SSL/TLS encryption
- Image formats (JPEG, PNG)
- Video codecs (H.264)

### Layer 5: Session
**What it does:** Establishes, maintains, and terminates connections between applications.

**Responsibilities:**
- Session setup and teardown
- Dialog control (who can talk when)
- Synchronization
- Recovery

**Protocols:**
- RPC (Remote Procedure Call)
- NetBIOS
- PPTP

### Layer 4: Transport
**What it does:** Manages end-to-end delivery of data.

**Two Main Protocols:**

#### TCP (Transmission Control Protocol)
- ✅ Connection-oriented (establishes connection first)
- ✅ Reliable (guarantees delivery)
- ✅ Ordered (data arrives in sequence)
- ⚠️ Slower, more overhead
- **Uses:** HTTP, HTTPS, SSH, FTP, Email

#### UDP (User Datagram Protocol)
- ✅ Connectionless (sends directly)
- ✅ Fast (minimal overhead)
- ⚠️ No guarantees (packets can be lost)
- ⚠️ Unordered
- **Uses:** DNS, VoIP, Gaming, Streaming, DHCP

**TCP 3-Way Handshake:**
```
Client → Server: SYN (synchronize, start connection)
Server → Client: SYN-ACK (acknowledge + sync back)
Client → Server: ACK (acknowledge receipt)
```

### Layer 3: Network
**What it does:** Routes data between different networks using IP addresses.

**Key Concepts:**
- **IP Addressing** — Unique addresses (IPv4 & IPv6)
- **Routing** — Determining the path packets take
- **Subnetting** — Dividing networks into smaller segments
- **ICMP** — Ping, traceroute

**IP Versions:**
- **IPv4** — 32-bit address (192.168.1.1)
- **IPv6** — 128-bit address (2001:0db8::1)

**Common Protocols:**
- IP (IPv4/IPv6)
- ICMP (ping, traceroute)
- IGMP (multicast)
- BGP (border gateway protocol)

**Security:**
- IP spoofing (faking source IP)
- DDoS attacks
- Subnet enumeration

### Layer 2: Data Link
**What it does:** Manages physical addressing using MAC addresses on a local network.

**Key Concepts:**
- **MAC Address** — Physical hardware address (48-bit, e.g., 00:1A:2B:3C:4D:5E)
- **Switching** — Moving data between devices on same network
- **ARP** — Maps IP addresses to MAC addresses

**Protocols:**
- Ethernet (wired)
- 802.11 (WiFi)
- PPP (Point-to-Point Protocol)
- ARP (Address Resolution Protocol)

**Sub-layers:**
- **Logical Link Control (LLC)** — Flow control, error checking
- **Media Access Control (MAC)** — Physical addressing, switching

**Security Issues:**
- ARP spoofing
- MAC flooding
- MAC cloning
- VLAN hopping

### Layer 1: Physical
**What it does:** Transmits raw bits (1s and 0s) over physical media.

**Physical Media:**
- Copper cables (Twisted pair, coaxial)
- Fiber optic cables
- Wireless/radio waves

**Concepts:**
- Voltage levels
- Frequency
- Wavelength
- Impedance

**Equipment:**
- Hubs
- Repeaters
- Cables
- Network adapters

**Security:**
- Cable interception
- Jamming (wireless)
- Physical damage

## How Data Flows Through Layers

### Sending (Down the Stack)
```
Application (HTTP request)
    ↓ Segment
Transport (TCP header added)
    ↓ Packet
Network (IP header added)
    ↓ Frame
Data Link (MAC header added)
    ↓ Bits
Physical (transmitted as electrical signals)
```

### Receiving (Up the Stack)
```
Physical (electrical signals)
    ↓
Data Link (MAC addresses checked)
    ↓
Network (IP routing)
    ↓
Transport (TCP/UDP processing)
    ↓
Application (application receives data)
```

## Memory Aid: PDN-TSA-PH

**P**hysical → **D**ata Link → **N**etwork → **T**ransport → **S**ession → **P**resentation → **A**pplication

Or reverse: **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing

## Common Attacks by Layer

| Layer | Attack | Example | Prevention |
|-------|--------|---------|------------|
| 7 | SQL Injection | `' OR '1'='1` | Input validation |
| 6 | Man-in-the-Middle | SSL stripping | Use HTTPS always |
| 5 | Session hijacking | Cookie theft | Secure tokens, HTTPS |
| 4 | Port scanning | Nmap | Firewall rules |
| 3 | IP spoofing | Fake source IP | Ingress filtering |
| 2 | ARP spoofing | Fake MAC | ARP monitoring |
| 1 | Jamming | Radio interference | Physical security |

## Network Troubleshooting with OSI

**Problem:** Can't reach website

1. **Layer 1:** Check if cables are connected
2. **Layer 2:** Check if MAC address is working (`arp -a`)
3. **Layer 3:** Check if IP is assigned (`ipconfig` or `ifconfig`)
4. **Layer 4:** Check if ports are open (`netstat`)
5. **Layer 5-6:** Check for connection issues
6. **Layer 7:** Check if application is responding

## Quick Tests by Layer

```bash
# Layer 1: Physical connection
ping 127.0.0.1  # Loopback

# Layer 2: Local network
arp -a  # See MAC addresses
ip link  # Check interface status

# Layer 3: IP routing
ipconfig / ifconfig  # Check IP
route -n  # Check routing table
ping 8.8.8.8  # Google DNS

# Layer 4: Ports & services
netstat -tuln  # Check open ports
ss -tuln  # Modern alternative
telnet host port  # Check connection

# Layer 7: Application
curl https://example.com  # HTTP/HTTPS test
nslookup example.com  # DNS test
```

## Related Resources

- [TCP vs UDP](TCP-UDP.md) — Transport layer protocols in detail
- [IP Addressing](IP-Addressing.md) — Network layer concepts
- [DNS](DNS.md) — Application layer protocol
- [HTTPS/TLS](HTTPS-TLS.md) — Secure communication

---

**Last Updated:** September 28, 2026