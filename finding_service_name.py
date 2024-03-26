import socket

def find_service_name():
    protocolname = 'tcp'
    for port in [443, 25, 20, 21, 22, 23]:
        print ("Port: %s => service name: %s" %(port, socket.getservbyport(port, protocolname)))
    
    print ("Port: %s => service name: %s" %(53, socket.getservbyport(53, 'udp')))
    
if __name__ == '__main__':
    find_service_name()
