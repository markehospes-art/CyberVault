# Subnetting

## Overview
Subnetting is dividing a network into smaller sub-networks (subnets) to improve efficiency, security, and organization of IP addresses.

## Why Subnet?

✅ **Reduce congestion**: Smaller broadcast domains
✅ **Improve security**: Isolate network segments
✅ **Better organization**: Logical network structure
✅ **Efficient IP use**: Only allocate what you need
✅ **Easier management**: Separate departments/functions

## Subnet Mask Basics

### Understanding CIDR Notation

`/` followed by number = bits dedicated to network portion

```
192.168.1.0/24
└─ /24 means: first 24 bits = network, last 8 bits = host

192.168.1.0/25
└─ /25 means: first 25 bits = network, last 7 bits = host
```

### Conversion Table

| CIDR | Decimal Mask | Hosts |
|------|--------------|-------|
| /24 | 255.255.255.0 | 254 |
| /25 | 255.255.255.128 | 126 |
| /26 | 255.255.255.192 | 62 |
| /27 | 255.255.255.224 | 30 |
| /28 | 255.255.255.240 | 14 |
| /29 | 255.255.255.248 | 6 |
| /30 | 255.255.255.252 | 2 |

## Subnetting a Network

### Example: Subnet 192.168.1.0/24 into /26 subnets

**Original**
- Network: 192.168.1.0/24
- Hosts available: 254
- Last octet: 00000000 - 11111111

**New subnets (/26)**
- Each subnet: 64 addresses (62 usable hosts)
- Subnet bits: Last 2 bits of /24 → /26

### Step-by-Step

1. **Identify network and host bits**
   - /24 = 24 network bits, 8 host bits
   - /26 = 26 network bits, 6 host bits
   - Need 2 more network bits

2. **Calculate subnets**
   - 2² = 4 subnets
   - 2⁶ = 64 addresses per subnet

3. **Subnet addresses**
   ```
   Subnet 1: 192.168.1.0/26    (0-63)
   Subnet 2: 192.168.1.64/26   (64-127)
   Subnet 3: 192.168.1.128/26  (128-191)
   Subnet 4: 192.168.1.192/26  (192-255)
   ```

### Usable Hosts per Subnet

```
192.168.1.0/26
├─ Network address: 192.168.1.0 (not usable)
├─ Usable hosts: 192.168.1.1 - 192.168.1.62
└─ Broadcast: 192.168.1.63 (not usable)

Total addresses: 64
Usable hosts: 62
```

## Subnetting Calculation Formula

### Number of Subnets
```
Subnets = 2^(new bits)
Example: /24 to /26 = 2^(26-24) = 2² = 4 subnets
```

### Hosts per Subnet
```
Hosts = 2^(host bits) - 2
Example: /26 has 6 host bits = 2⁶ - 2 = 62 hosts
```

### Increment Between Subnets
```
Increment = 2^(8 - subnet_bits_in_last_octet)
Example: /26 has 2 subnet bits = 2^(8-2) = 64
Subnets: 0, 64, 128, 192
```

## Common Subnet Scenarios

### Small Office (need 30 hosts)
- Use /26 (62 hosts per subnet)
- 192.168.1.0/26

### Medium Network (need 100 hosts)
- Use /25 (126 hosts per subnet)
- 192.168.1.0/25

### Large Network (need 500 hosts)
- Use /23 (510 hosts per subnet)
- 192.168.0.0/23

## Best Practices

✅ **Plan for growth**: Allocate more than currently needed
✅ **Use standard sizes**: /24, /25, /26 are common
✅ **Document clearly**: Keep subnet records updated
✅ **Reserve ranges**: Set aside IPs for servers, VIPs
✅ **Separate concerns**: Different subnets for different functions

## Example Network Design

```
10.0.0.0/16 (Main network - 65,534 hosts)
├─ 10.0.1.0/24   (Administration) - 254 hosts
├─ 10.0.2.0/24   (Sales) - 254 hosts
├─ 10.0.3.0/24   (Engineering) - 254 hosts
├─ 10.0.4.0/24   (Guest WiFi) - 254 hosts
└─ 10.0.5.0/24   (Servers) - 254 hosts
```

## Troubleshooting Commands (Educational)

### Check your subnet
```bash
ipconfig /all          # Windows - shows subnet mask
ifconfig              # Linux/Mac - shows netmask
```

### Test connectivity between subnets
```bash
ping 192.168.1.1      # Test host in same subnet
ping 192.168.2.1      # Test host in different subnet
```

## Key Takeaways

- Subnetting divides networks into smaller segments
- /24 → /25 doubles the subnets and halves the hosts
- Network + Host bits = total address bits
- Reserve first (network) and last (broadcast) addresses
- Proper subnetting improves security and efficiency