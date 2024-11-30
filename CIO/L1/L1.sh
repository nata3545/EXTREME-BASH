#!/bin/bash

# |=====================|
# | Versias 1.1 [PUPS]  |
# |=====================|
# L1.cfg - configuration file
# !! FILE L1.cfg MUST BE IN THE SAME FOLDERS AS L1.sh !!
# PUMPKIN YA DADA 
source ./L1.cfg

#Function to check cfg file in fn1
if [[ ! -f "$fn1" ]]; then
    echo "File $fn1 does not exist!"
fi
#Function to check cfg file in fn2
if [[ ! -f "$fn2" ]]; then
    echo "File $fn2 does not exist!"
fi
#Function to check cfg file in fn3
if [[ ! -f "$fn3" ]]; then
    echo "File $fn3 does not exist!"
fi

# Function to check if the user is root
is_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Root privileges are required for some commands."
        return 1  # Not root
    else
        return 0  # Root
    fi
}
echo "==========================================="
echo "Script start. by PUMPKIN YA DADA"
echo "==========================================="
# -------------------------------------------------
# Function to get system information
# -------------------------------------------------
get_system_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: SYSTEM-DISTRIBUTION ::::::::"
        cat /etc/*-release
        echo "+--------------------------------------+"
        cat /proc/version
        uname -a
        uname -mrs
        uname -m
        rpm -q kernel
        dmesg | grep Linux
        ls /boot | grep vmlinuz
    fi 
}

# -------------------------------------------------
# Function to get network information
# -------------------------------------------------
get_network_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: NETWORKS ::::::::"
        /sbin/ifconfig -a
        cat /etc/network/interfaces
        iptables -L
        hostname
        dnsdomainname
    fi
}

# -------------------------------------------------
# Function to get process and application information
# -------------------------------------------------
get_processes_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: PROCESSES-APPLICATIONS ::::::::"
        ps aux
        ps -ef
        cat /etc/services
        ps aux | grep root
        ps -ef | grep root
        ls -alh /usr/bin/
        ls -alh /sbin/
        dpkg -l
        crontab -l
        ls -alh /var/spool/cron
        ls -al /etc/ | grep cron
        ls -al /etc/cron*
        cat /etc/cron*
        cat /etc/crontab
    fi
}

# -------------------------------------------------
# Function to get user information
# -------------------------------------------------
get_user_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: WHO-AM-I ::::::::"
        id
        who
        w
        last
        cat /etc/passwd | cut -d: -f1  # List of users
        awk -F: '($3 == "0") {print}' /etc/passwd  # List of super users
    fi
}

# -------------------------------------------------
# Function to get network connections and services
# -------------------------------------------------
get_connection_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: USERS-HOST ::::::::"
        lsof -i
        lsof -i :80
        grep 80 /etc/services
        netstat -antup
        netstat -antpx
        netstat -tulpn
        chkconfig --list
        chkconfig --list | grep 3:on
        last
        w
    fi
}

# -------------------------------------------------
# Function to get log and audit information
# -------------------------------------------------
get_logs_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: LOGS-LOG-AUDIT ::::::::"
        #cat ~/.bash_history
        cat ~/.*sh_history
        cat ~/.nano_history
        cat ~/.atftp_history
        cat ~/.mysql_history
        cat ~/.php_history
    fi
}

# -------------------------------------------------
# Function to get passwd and shadow information
# -------------------------------------------------
get_passwd_shadow_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: PASSWD-SHADOW ::::::::"
        cat /etc/passwd
        cat /etc/group
        ls -alh /var/mail/
        ls -ahlR /home/
        # The next lines require root privileges
        # cat /etc/shadow  # Requires root
        # ls -ahlR /root/  # Requires root
    fi
}

# -------------------------------------------------
# Function to grep for passwords and user information
# -------------------------------------------------
get_passwd_shadow_grep_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: PASSWD-SHADOW-GREP ::::::::"
        grep -i user $fn1  #--> L1.cfg
        grep -i pass $fn2  #--> L1.cfg
        grep -C 5 "password" $fn3  #--> L1.cfg
    fi
}

# -------------------------------------------------
# Function to get general information
# -------------------------------------------------
get_general_info() {
    if [$1 -eq 1] 
    then
        echo ":::::::: OTHER-INFO ::::::::"
        echo -e "\nDate-"
        date
        echo -e "\nSudo-"
        sudo -l
        echo "SMART disk status:"
        # The following block requires root privileges
        if is_root; then
            # Example of checking SMART status
            for disk in /dev/sd?; do
                echo "SMART status for $disk:"
                smartctl -a $disk | grep -i "smart"
            done
        fi

        if command -v sensors &> /dev/null; then
            echo -e "\nCPU temperature:"
            sensors
        else
            echo -e "\nError -sensor"
        fi

        echo -e "\nJournal logs:"
        # The following line requires root privileges
        if is_root; then
            journalctl -n 20
        fi
    fi
}
# -------------------------------------------------
# Function to get ssh gnupg dir
# -------------------------------------------------
get_ssh_gnupg_dir() { #need root
    if [$1 -eq 1] 
    then
        echo ":::::::: SSH-GNUPG-DIR ::::::::"
        SSH_DIR="$HOME/.ssh"
        GNUPG_DIR="$HOME/.gnupg"
        # Check if the directories exist
        if [ ! -d "$SSH_DIR" ]; then #need root
            echo "Error: directory $SSH_DIR does not exist!"
            exit 1
        fi
        if [ ! -d "$GNUPG_DIR" ]; then #need root
            echo "Error: directory $GNUPG_DIR does not exist!"
            exit 1
        fi
        # Show contents of ~/.ssh
        echo "Contents of $SSH_DIR:"
        ls -l "$SSH_DIR"
        echo
        # Show contents of ~/.gnupg
        echo "Contents of $GNUPG_DIR:"
        ls -l "$GNUPG_DIR"
        echo
    fi
}
# -------------------------------------------------
# Function to get hosts ssh config
# -------------------------------------------------
get_hosts_ssh_config () {
    if [$1 -eq 1] 
    then
        echo ":::::::: HOSTS-SSH-CONFIG ::::::::"
        # Define the known hosts file and SSH configuration file
        KNOWN_HOSTS="$HOME/.ssh/known_hosts"
        SSH_CONFIG="$HOME/.ssh/config"
        # Check if the known_hosts file exists
        if [ -f "$KNOWN_HOSTS" ]; then
            echo "Contents of the file $KNOWN_HOSTS (known hosts):"
            cat "$KNOWN_HOSTS"
        else
            echo "Error: file $KNOWN_HOSTS not found!"
        fi
        echo

        # Check if the SSH config file exists
        if [ -f "$SSH_CONFIG" ]; then
            echo "Contents of the file $SSH_CONFIG (SSH configuration):"
            cat "$SSH_CONFIG"
        else
            echo "Error: file $SSH_CONFIG not found!"
        fi
    fi 
}
# PUMPKIN YA DADA
# -------------------------------------------------
# Call all functions
# -------------------------------------------------
# !!! OPEN L1.cfg TO CUSTOMIZE THE SCRIPT BY CHANGING THE VALUE OF VARIABLES !!!
# NAME VARIABLES IN L1.CFG                              BY DEFAULT ALL SETTINGS ARE 1         
get_system_info $system_info                            # system_info
get_network_info $network_info                          # network_info
get_processes_info $processes_info                      # processes_info
get_user_info $user_info                                # user_info
get_connection_info $connection_info                    # connection_info
get_logs_info $logs_info                                # logs_info
get_passwd_shadow_info $passwd_shadow_info              # passwd_shadow_info
get_passwd_shadow_grep_info $passwd_shadow_grep_info    # passwd_shadow_grep_info
get_general_info $general_info                          # general_info
get_ssh_gnupg_dir $ssh_gnupg_dir                        # ssh_gnupg_dir
get_hosts_ssh_config $hosts_ssh_config                  # hosts_ssh_config
# PUMPKIN YA DADA
echo "==========================================="
echo "Script finished. by PUMPKIN YA DADA"
echo "==========================================="
# PUMPKIN YA DADA