#!/bin/bash
#OS-INFO
printf 'OS INFO:\n'
(cat /proc/version || uname -a ) 2>/dev/null | awk '{print $3" "$19" "$20" "$21}'
printf '\n'

#RELEASE-INFO
printf 'RELEASE INFO:\n'
lsb_release -a 2>/dev/null | grep 'Release'
printf '\n'

#SUDO VERSION
printf 'SUDO VERSION\n'
sudo --version | head -1

#USER SUDO PRIV INFO
printf 'SUDO PRIV:\n'
printf "HAVE CREDS??\n"
printf "Y|N\n"
read input
if [[ $input == "Y" || $input == "y" ]]; then
	printf "Enter creds\n"
	sudo -l 
fi

#Groups 
printf 'Inresting Groups\n'
id
printf '\n'
#PATH-Info
printf 'PATH INFO:\n'
printf $PATH
printf '\n'

#PRINTER INFO
printf 'PRINTER INFO:\n'
lpstat -a 2>/dev/null 
printf '\n'

#COMPILER INFO
printf 'COMPILER INFO:\n'
(dpkg --list 2>/dev/null | grep "compiler" | grep -v "decompiler\|lib" 2>/dev/null || yum list installed 'gcc*' 2>/dev/null | grep gcc 2>/dev/null; which gcc g++ 2>/dev/null || locate -r "/gcc[0-9\.-]\+$" 2>/dev/null | grep -v "/doc/")
printf '\n'

#PROCESS INFO
printf 'PROCESS INFO:\n'
ps -ef | grep -e 'root'
printf '\n'

#CRON INFO
printf 'CRON INFO:\n'
cat /etc/cron* /etc/anacrontab /var/spool/cron/crontabs/root 2>/dev/null | grep -v "^#" 
printf '\n'

#PORTS INFO
printf 'PORTS INFO:\n'
ss -lnptu
printf '\n'

#ROOT USER INFO
printf 'ROOT USERS:\n'
awk -F:\n '($3 == "0") {print}' /etc/passwd
printf '\n'

#SHELL USER INFO
printf 'SHELL USERS:\n'
cat /etc/passwd | grep -E "sh$|bash" 
printf '\n'

#SUID USER INFO
printf 'SUID INFO:\n'
find / -perm -4000 2>/dev/null
printf '\n'

#SUDOERS USER INFO
printf 'SUDOERS INFO:\n'
ls -l /etc/sudoers /etc/sudoers.d
printf '\n'

#BACKUP FILES
printf 'BACKUP FILEs:\n'
find /mnt /opt /media /var /etc /bin /sbin /home /usr/local/bin /usr/local/sbin /usr/bin /usr/games /usr/sbin /root /tmp -type f \( -name "*backup*" -o -name "*\.bak" -o -name "*\.bck" -o -name "*\.bk" \) 2>/dev/null
printf '\n'

#LOGIN 
printf 'LAST LOGIN:\n'
last | tail
printf '\n'


#PRINT
printf 'CLIPBOARD HISTORY:\n'
if [ `which xclip 2>/dev/null` ]; then
    echo "Clipboard: "`xclip -o -selection clipboard 2>/dev/null`
    echo "Highlighted text: "`xclip -o 2>/dev/null`
  elif [ `which xsel 2>/dev/null` ]; then
    echo "Clipboard: "`xsel -ob 2>/dev/null`
    echo "Highlighted text: "`xsel -o 2>/dev/null`
  else echo "Not found xsel and xclip"
  fi
printf '\n'

#Password Keyfiles
printf 'Files containing Password keywords:\n'
grep --color=auto -rnw '/' --exclude-dir={bin,lib\*,boot,run,sys,proc,.cargo\*,.python\*} -ie "PASSWORD" -A 2 --color=always 2> /dev/null | head -n 100
printf 'Only 100 lines are shown\n'
printf '\n'


#SSH keys
printf 'SSH keys:\n'
find / -name authorized_keys 2> /dev/null
find / -name id_rsa 2> /dev/null
printf '\n'

#Capabilities
printf 'Capabilites:\n'
$(which getcap) -r  /usr/bin
printf '\n'

#Files owned
printf 'Files owned by Me:\n'
find /mnt /opt /media /var /etc /bin /sbin /home /usr/local/bin /usr/local/sbin /usr/bin /usr/games /usr/sbin /root /tmp -type f -user $(whoami) 2>/dev/null | grep --color=auto -v 'proc\|sys\|run' --color=always | head -n 100
printf 'Only 100 lines are shown\n'
printf '\n'

printf 'Directories owned by Me:\n'
find /mnt /opt /media /var /etc /bin /sbin /home /usr/local/bin /usr/local/sbin /usr/bin /usr/games /usr/sbin /root /tmp -type f -user $(whoami) 2>/dev/null | grep --color=auto -v 'proc\|sys\|run' --color=always | head -n 100
printf 'Only 100 lines are shown\n'

printf '\n'
