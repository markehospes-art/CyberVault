# TCP vs UDP - Transport Layer Protocols

## Overview
Both TCP and UDP are Layer 4 (Transport) protocols that handle data transmission, but they work very differently.

## TCP (Transmission Control Protocol)

### Characteristics
- **Connection-oriented**: Establishes connection before sending data (3-way handshake)
- **Reliable**: Guarantees data delivery in correct order
- **Error checking**: Detects and corrects errors
- **Slower**: More overhead due to reliability features
- **Flow control**: Manages data transmission rate

### Use Cases
- Email (SMTP, POP3)
- Web browsing (HTTP/HTTPS)
- File transfer (FTP)
- Remote access (SSH, Telnet)
- Database connections

### TCP Connection (3-Way Handshake)
1. **SYN**: Client sends synchronization packet
2. **SYN-ACK**: Server responds with acknowledgment
3. **ACK**: Client acknowledges server response
4. Connection established → Data transmission → Connection close

## UDP (User Datagram Protocol)

### Characteristics
- **Connectionless**: No connection establishment
- **Unreliable**: No guarantee of delivery
- **No error correction**: Lost packets aren't retransmitted
- **Faster**: Minimal overhead
- **No flow control**: Sends data at application speed

### Use Cases
- Live video/audio streaming
- Online gaming
- DNS queries
- VoIP (Voice over IP)
- Network management (SNMP)
- Real-time applications

## Comparison Table

| Feature | TCP | UDP |
|---------|-----|-----|
| Connection | Required | Not required |
| Reliability | Guaranteed | Best effort |
| Ordering | Ordered | No ordering |
| Speed | Slower | Faster |
| Header Size | 20-60 bytes | 8 bytes |
| Error Checking | Yes | Checksum only |
| Flow Control | Yes | No |
| Congestion Control | Yes | No |

## Packet Structure

### TCP Segment
- Source Port (16 bits)
- Destination Port (16 bits)
- Sequence Number
- Acknowledgment Number
- Flags (SYN, ACK, FIN, RST, etc.)
- Window Size
- Checksum

### UDP Datagram
- Source Port (16 bits)
- Destination Port (16 bits)
- Length
- Checksum

## When to Use What?

**Use TCP when**: Accuracy matters more than speed
**Use UDP when**: Speed matters more than accuracy