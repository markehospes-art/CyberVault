#!/usr/bin/env python3
"""
Local Network Port Scanner - EDUCATIONAL USE ONLY

This is a SAFE learning tool that only scans localhost (127.0.0.1)
and local network addresses. It is NOT for scanning external targets.

Purpose: Understand how port scanning works and network diagnostics
License: Educational - Lab Use Only
"""

import socket
import sys
from datetime import datetime

# ============================================================================
# CONFIGURATION - SAFE DEFAULTS
# ============================================================================

# Only scan localhost by default
DEFAULT_HOST = "127.0.0.1"
PORT_RANGE_START = 1
PORT_RANGE_END = 1024  # Common ports
TIMEOUT = 1  # Connection timeout in seconds

# Whitelist of allowed hosts (localhost and local networks only)
ALLOWED_HOSTS = [
    "127.0.0.1",
    "localhost",
    "192.168.1",
    "192.168.0",
    "10.0.0",
]

# ============================================================================
# COMMON PORT DEFINITIONS
# ============================================================================

COMMON_PORTS = {
    21: "FTP",
    22: "SSH",
    23: "Telnet",
    25: "SMTP",
    53: "DNS",
    80: "HTTP",
    110: "POP3",
    143: "IMAP",
    443: "HTTPS",
    445: "SMB",
    3306: "MySQL",
    3389: "RDP",
    5432: "PostgreSQL",
    5900: "VNC",
    8080: "HTTP Alt",
    8443: "HTTPS Alt",
}

# ============================================================================
# SAFETY CHECKS
# ============================================================================

def is_safe_host(host):
    """
    Verify that the target host is in the allowed safe list.
    This prevents accidental or intentional external scanning.
    """
    # Check exact matches
    if host in ALLOWED_HOSTS:
        return True
    
    # Check local network ranges
    for allowed in ALLOWED_HOSTS:
        if host.startswith(allowed):
            return True
    
    return False

# ============================================================================
# PORT SCANNING FUNCTION
# ============================================================================

def scan_port(host, port):
    """
    Attempt to connect to a specific port using TCP.
    
    Args:
        host (str): Target hostname or IP address
        port (int): Port number to scan
    
    Returns:
        bool: True if port is open, False if closed
    """
    try:
        # Create a socket object
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        # Set timeout to avoid hanging on unresponsive ports
        sock.settimeout(TIMEOUT)
        
        # Attempt TCP connection
        result = sock.connect_ex((host, port))
        
        # Close the socket
        sock.close()
        
        # 0 = success, port is open
        return result == 0
    
    except socket.gaierror:
        print(f"[-] Hostname {host} could not be resolved")
        return False
    
    except socket.error:
        print(f"[-] Could not connect to {host}")
        return False

# ============================================================================
# MAIN SCANNING FUNCTION
# ============================================================================

def scan_ports(host, port_start=PORT_RANGE_START, port_end=PORT_RANGE_END):
    """
    Scan a range of ports on the target host.
    
    Args:
        host (str): Target hostname or IP
        port_start (int): First port to scan
        port_end (int): Last port to scan
    """
    
    # Safety check
    if not is_safe_host(host):
        print(f"\n[!] ERROR: Target '{host}' is not in the allowed safe list!")
        print(f"[!] This scanner is for EDUCATIONAL use on localhost/local networks only.")
        print(f"[!] Allowed targets: {', '.join(ALLOWED_HOSTS)}")
        sys.exit(1)
    
    print("\n" + "="*60)
    print("CYBERVAULT - LOCAL PORT SCANNER (EDUCATIONAL)")
    print("="*60)
    print(f"[*] Target: {host}")
    print(f"[*] Scanning ports {port_start}-{port_end}")
    print(f"[*] Timeout: {TIMEOUT} seconds")
    print(f"[*] Start time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*60 + "\n")
    
    open_ports = []
    
    try:
        # Scan each port in range
        for port in range(port_start, port_end + 1):
            # Show progress
            print(f"[*] Scanning port {port}...", end='\r')
            
            # Check if port is open
            if scan_port(host, port):
                # Get service name if known
                service = COMMON_PORTS.get(port, "Unknown")
                
                print(f"[+] Port {port:5d} is OPEN  - {service:<15s}")
                open_ports.append(port)
    
    except KeyboardInterrupt:
        print("\n\n[!] Scan interrupted by user.")
        sys.exit(1)
    
    # Print summary
    print("\n" + "="*60)
    print("SCAN SUMMARY")
    print("="*60)
    print(f"[*] End time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"[*] Total ports scanned: {port_end - port_start + 1}")
    print(f"[+] Open ports found: {len(open_ports)}")
    
    if open_ports:
        print("\n[+] Open ports:")
        for port in open_ports:
            service = COMMON_PORTS.get(port, "Unknown")
            print(f"    - Port {port}: {service}")
    else:
        print("\n[-] No open ports found in the scanned range.")
    
    print("\n" + "="*60 + "\n")

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

def print_usage():
    """
    Display usage instructions.
    """
    print("\nUsage: python3 port_scanner.py [host] [start_port] [end_port]")
    print("\nExamples:")
    print("  python3 port_scanner.py                    # Scan localhost (127.0.0.1) ports 1-1024")
    print("  python3 port_scanner.py 127.0.0.1          # Scan localhost")
    print("  python3 port_scanner.py 192.168.1.100      # Scan local network host")
    print("  python3 port_scanner.py 127.0.0.1 1 65535  # Scan all ports on localhost")
    print("\nSAFETY: This tool only works on localhost and local networks (192.168.x.x, 10.0.0.x)")
    print("        It is designed for EDUCATIONAL purposes and lab environments only.\n")

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

if __name__ == "__main__":
    # Parse command line arguments
    if len(sys.argv) > 1 and sys.argv[1] in ["-h", "--help"]:
        print_usage()
        sys.exit(0)
    
    # Get host from arguments or use default
    host = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_HOST
    
    # Get port range from arguments or use defaults
    port_start = int(sys.argv[2]) if len(sys.argv) > 2 else PORT_RANGE_START
    port_end = int(sys.argv[3]) if len(sys.argv) > 3 else PORT_RANGE_END
    
    # Run the scan
    scan_ports(host, port_start, port_end)
