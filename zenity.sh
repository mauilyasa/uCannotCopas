#!/bin/bash

# Function to add iptables rule
add_rule() {
    protocol=$1
    action=$2
    port=$3
    iptables -A INPUT -p $protocol --dport $port -j $action
}

# Function to display error message
display_error() {
    zenity --error --text="$1"
    exit 1
}

# Display dialog to choose application
application=$(zenity --list \
                   --title="Choose Application" \
                   --text="Select an application to configure:" \
                   --column="Application" telnet ssh http ftp \
                   --width=300 \
                   --height=250)

# Display dialog to choose action
action=$(zenity --list \
               --title="Choose Action" \
               --text="Select an action for $application:" \
               --column="Action" Reject Drop Accept \
               --width=300 \
               --height=250)

# Determine protocol and port based on application
case $application in
    "telnet")
        protocol="tcp"
        port="23"
        ;;
    "ssh")
        protocol="tcp"
        port="22"
        ;;
    "http")
        protocol="tcp"
        port="80"
        ;;
    "ftp")
        protocol="tcp"
        port="21"
        ;;
    *)
        display_error "Invalid application!"
        ;;
esac

# Determine action
case $action in
    "Reject")
        action="REJECT"
        ;;
    "Drop")
        action="DROP"
        ;;
    "Accept")
        action="ACCEPT"
        ;;
    *)
        display_error "Invalid action!"
        ;;
esac

# Add iptables rule
add_rule $protocol $action $port

zenity --info --text="iptables rule for $application has been configured with action $action on port $port."
