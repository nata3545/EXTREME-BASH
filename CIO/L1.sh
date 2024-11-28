#!/bin/bash

# |=====================|
# | Versias 1.1 [PUPS]  |
# |=====================|
#
#L1.cfg - conf file

echo ":::::::: SYSTEM-DISTRIBUTION ::::::::"
cat /etc/*-release
echo "+--------------------------------------+"
cat /proc/version 
uname -a
uname -mrs 
rpm -q kernel 
dmesg | grep Linux 
ls /boot | grep vmlinuz 

echo ":::::::: NETWORKS ::::::::"
/sbin/ifconfig -a 
cat /etc/network/interfaces 
#cat /etc/sysconfig/network
#cat /etc/network  
#cat /etc/sysconfig/network
iptables -L
hostname 
dnsdomainname

echo ":::::::: PROCESSES-APPLICATIONS ::::::::"
ps aux 
ps -ef 
cat /etc/services 
ps aux | grep root 
ps -ef | grep root 
ls -alh /usr/bin/ 
ls -alh /sbin/ 
dpkg -l 
#rpm -qa 
#ls -alh /var/cache/apt/archivesO
#ls -alh /var/cache/yum/
crontab -l 
ls -alh /var/spool/cron 
ls -al /etc/ | grep cron
ls -al /etc/cron*
cat /etc/cron*
#cat /etc/at.allow
#cat /etc/at.deny
#cat /etc/cron.allow
#cat /etc/cron.deny
cat /etc/crontab
#cat /etc/anacrontab
#cat /var/spool/cron/crontabs/roo

echo ":::::::: WHO-AM-I ::::::::"
id 
who 
w
last
cat /etc/passwd | cut -d: -f1    # List of users 
#grep -v -E "^#" /etc/passwd | awk -F: '$3 == 0 { print $1}'   # List of super users
awk -F: '($3 == "0") {print}' /etc/passwd   # List of super users
#cat /etc/sudoers
#cat /etc/sudoers # need root

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

echo ":::::::: LOGS-LOG-AUDIT ::::::::"
cat ~/.bash_history
cat ~/.nano_history
cat ~/.atftp_history
cat ~/.mysql_history
cat ~/.php_history

echo ":::::::: PASSWD-SHADOW ::::::::"
cat /etc/passwd
cat /etc/group
#cat /etc/shadow # need root 
ls -alh /var/mail/
#ls -ahlR /root/ # need root
ls -ahlR /home/

echo ":::::::: PASSWD-SHADOW-GREP ::::::::"
grep -i user [filename]
grep -i pass [filename]
grep -C 5 "password" [filename]