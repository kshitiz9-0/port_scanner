#!/usr/bin/python3
import socket
import sys
import threading

def scan_port(address, port):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket.setdefaulttimeout(0.5)
    result = s.connect_ex((address, port))
    if result == 0:
        print("[*] Port {} is open".format(port))
    s.close()

if len(sys.argv) != 4:
    print("Usage: python3 port_scanner.py IP_ADDRESS START_PORT END_PORT")
    sys.exit()

address = socket.gethostbyname(sys.argv[1])
start_port = int(sys.argv[2])
end_port = int(sys.argv[3])

print("-" * 100)
print("Scanning ip:", address)
print("-" * 100)

try:
    for port in range(start_port, end_port + 1):
        thread = threading.Thread(target=scan_port, args=(address, port))
        thread.start()

except KeyboardInterrupt:
    print("\nExiting...!!")
    sys.exit()

except socket.error:
    print("\nNot Responding..!")
    sys.exit()

