# vi ~/dbset2.sh
#!/bin/bash
server_chk=$(cat /etc/my.cnf | grep server-id)
masterIp=@masterIp@
slaveIp=@slaveIp@
localIp=$(hostname -I | cut -d' ' -f1 | cut -d'.' -f4)
if [ -n "$server_chk" ];
then
        echo 'server id is already defined.'
else
        sed -i -e '2i\server-id='$localIp'' /etc/my.cnf
        if [[ $slaveIp -eq $localIp ]]; then
                sed -i -e "2i\replicate-do-db='webdb'" /etc/my.cnf
        fi
fi
log=@File@
pos=@Pos@
if [[ $slaveIp -eq $localIp ]]; then
        mysql -u root -p1 -e "CHANGE MASTER TO MASTER_HOST='$masterIp', MASTER_USER='Rep_user', MASTER_PASSWORD='itbank', MASTER_LOG_FILE='$log', MASTER_LOG_POS=$pos;"
        systemctl restart mariadb
fi