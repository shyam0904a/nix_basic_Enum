!#/bin/bash
#OS-INFO
echo 'OS INFO:'
(cat /proc/version || uname -a ) 2>/dev/null | awk '{print $3" "$19" "$20" "$21}'
echo '\n'

#RELEASE-INFO
echo 'RELEASE INFO:'
lsb_release -a 2>/dev/null | grep 'Release'
echo '\n'

#PATH-Info
echo 'PATH INFO:'
echo $PATH
echo '\n'

#PRINTER INFO
echo 'PRINTER INFO:'
lpstat -a 2>/dev/null 
echo '\n'

#COMPILER INFO
echo 'COMPILER INFO:'
(dpkg --list 2>/dev/null | grep "compiler" | grep -v "decompiler\|lib" 2>/dev/null || yum list installed 'gcc*' 2>/dev/null | grep gcc 2>/dev/null; which gcc g++ 2>/dev/null || locate -r "/gcc[0-9\.-]\+$" 2>/dev/null | grep -v "/doc/")
echo '\n'

#PROCESS INFO
echo 'PROCESS INFO:'
ps -ef | grep
echo '\n'

#CRON INFO
echo 'CRON INFO:'
cat /etc/cron* /etc/anacrontab /var/spool/cron/crontabs/root 2>/dev/null | grep -v "^#" 
echo '\n'

#PORTS INFO
echo 'PORTS INFO:'
ss -lnpt
echo '\n'

#ROOT USER INFO
echo 'ROOT USERS:'
awk -F: '($3 == "0") {print}' /etc/passwd
echo '\n'

#SHELL USER INFO
echo 'SHELL USERS:'
cat /etc/passwd | grep -E "sh$|bash" 
echo '\n'

#SUID USER INFO
echo 'SUID INFO:'
find / -perm -4000 2>/dev/null
echo '\n'

#SUDOERS USER INFO
echo 'SUDOERS INFO:'
ls -l /etc/sudoers /etc/sudoers.d
echo '\n'

#BACKUP FILES
echo 'BACKUP FILEs:'
find /mnt /opt /media /var /etc /bin /sbin /home /usr/local/bin /usr/local/sbin /usr/bin /usr/games /usr/sbin /root /tmp -type f \( -name "*backup*" -o -name "*\.bak" -o -name "*\.bck" -o -name "*\.bk" \) 2>/dev/null


#USER SUDO PRIV INFO
echo 'SUDO PRIV:'
sudo -l

