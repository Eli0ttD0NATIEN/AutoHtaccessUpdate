#!/usr/bin/bash
#Parameters
remote_host_ip='192.168.98.129'
remote_usr='test'
htaccess_path='/home/test/.htaccess'
file=$(basename -a $htaccess_path)


#Get .htaccess file from remote host
scp $remote_usr@$remote_host_ip:$htaccess_path /home/unixjesus/AutoHtacessUpdate/ & 
wait

#Remove last ip
sed -i '2d' .htaccess 

#"allow from" + Get Current IP address  
htaccess_var=$({ echo -n "allow from " && host myip.opendns.com resolver1.opendns.com | grep address | cut -d " " -f 4; }) 

#Insert htaccess_var into file
match='Ben'
sed -i "s/$match/$match\n$htaccess_var/" $file

#Copy file to remote host
scp -r .htaccess $remote_usr@$remote_host_ip:$htaccess_path



