#!/bin/bash

# Menampilkan dialog Zenity untuk memilih aplikasi
application=$(zenity --list --title="Pilih Aplikasi" --column="Aplikasi" "telnet" "ssh" "http" "ftp" --width=300 --height=300 --radiolist --separator=":" --text="Pilih aplikasi yang ingin diatur:")

# Memeriksa apakah pengguna memilih aplikasi
if [ -z "$application" ]; then
    zenity --error --text="Aplikasi tidak dipilih. Program berhenti."
    exit 1
fi

# Menampilkan dialog Zenity untuk memilih proses
process=$(zenity --list --title="Pilih Proses" --column="Proses" "Reject" "Drop" "Accept" --width=300 --height=300 --radiolist --separator=":" --text="Pilih proses untuk aplikasi $application:")

# Memeriksa apakah pengguna memilih proses
if [ -z "$process" ]; then
    zenity --error --text="Proses tidak dipilih. Program berhenti."
    exit 1
fi

# Menjalankan iptables sesuai pilihan pengguna
case "$process" in
    "Reject")
        sudo iptables -A INPUT -p tcp --dport $(get_port $application) -j REJECT
        ;;
    "Drop")
        sudo iptables -A INPUT -p tcp --dport $(get_port $application) -j DROP
        ;;
    "Accept")
        sudo iptables -A INPUT -p tcp --dport $(get_port $application) -j ACCEPT
        ;;
esac

# Menampilkan pesan berhasil
zenity --info --text="Aplikasi $application telah diatur untuk proses $process pada iptables."

# Fungsi untuk mendapatkan port berdasarkan aplikasi
get_port() {
    case "$1" in
        "telnet")
            echo "23"
            ;;
        "ssh")
            echo "22"
            ;;
        "http")
            echo "80"
            ;;
        "ftp")
            echo "21"
            ;;
    esac
}

exit 0
