
import socket
from binascii import hexlify

port = int(input("masukkan port protokol : "))
protocolname = 'tcp'
print("port : %s => service name : %s" %(port, socket.getservbyport(port, protocolname)))