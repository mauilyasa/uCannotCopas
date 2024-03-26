import socket

def get_remote_machine_info():
    host_name = socket.gethostname()
    ip_address = socket.gethostbyname(host_name)
    remote_host = input("Masukkan alamat web : ")
    try:
        remote_host_ip = socket.gethostbyname(remote_host)
    except socket.error as err_msg:
        print ("%s: %s" %(remote_host, err_msg))
    
    print("Anda mengakses %s dengan alamat IP %s dari komputer %s dengan alamat IP %s" %(remote_host, remote_host_ip,host_name,ip_address))

def find_service_name():
    port = int(input("masukkan port protokol : "))
    protocolname = 'tcp'
    print("port : %s => service name : %s" %(port, socket.getservbyport(port, protocolname)))
   
def menu():
    dt = "y"
    while dt == "y":
        print("MENU PILIHAN")
        print("1. Mengetahui service dan protocol")
        print("2. Mengetahui alamat IP")
        menu = int(input("Masukkan pilihan: "))
        if menu == 1:
            find_service_name()
        elif menu == 2:
            get_remote_machine_info()
        pil = input("Anda ingin mengulang (Y/T)")
        if pil == "y":
            dt == "y"
        else:
            break

if __name__ == '__main__':
    menu()
