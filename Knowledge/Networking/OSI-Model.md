# OSI Model - The 7 Layers

## Overview
The OSI (Open Systems Interconnection) model is a conceptual framework that standardizes how communication functions are organized in networking systems. It divides the communication process into 7 distinct layers.

## The 7 Layers (Top to Bottom)

### Layer 7: Application
- **Purpose**: User applications and services
- **Examples**: HTTP, HTTPS, FTP, SMTP, DNS, Telnet
- **Data Unit**: Data/Messages

### Layer 6: Presentation
- **Purpose**: Data formatting, encryption, compression
- **Examples**: SSL/TLS encryption, JPEG, GIF
- **Data Unit**: Data/Messages

### Layer 5: Session
- **Purpose**: Manages connections and sessions
- **Examples**: NetBIOS, PPTP, SIP
- **Data Unit**: Data/Messages

### Layer 4: Transport
- **Purpose**: End-to-end communication and reliability
- **Examples**: TCP, UDP, SCTP
- **Data Unit**: Segments (TCP) / Datagrams (UDP)

### Layer 3: Network
- **Purpose**: Routing and logical addressing
- **Examples**: IP, ICMP, IGMP
- **Data Unit**: Packets
- **Devices**: Routers

### Layer 2: Data Link
- **Purpose**: Physical addressing and frame transmission
- **Examples**: Ethernet, PPP, MAC addresses
- **Data Unit**: Frames
- **Devices**: Switches, Bridges

### Layer 1: Physical
- **Purpose**: Raw bit transmission over cables/wireless
- **Examples**: Ethernet cables, Fiber, WiFi signals
- **Data Unit**: Bits
- **Devices**: Hubs, Repeaters

## Memory Aid: "Please Do Not Throw Sausage Pizza Away"
- **P**hysical
- **D**ata Link
- **N**etwork
- **T**ransport
- **S**ession
- **P**resentation
- **A**pplication

## Key Concepts
- Each layer provides services to the layer above it
- Each layer adds its own header (encapsulation)
- Communication flows both up and down the stack
- Helps troubleshoot network issues by identifying which layer the problem exists