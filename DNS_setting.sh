# vi ~/DNS_setting.sh	
#!/bin/bash
domain=”kgmarket.net”
host=( “www”)

sed -i 's/listen-on port 53 { 127.0.0.1; };/listen-on port 53 { any; };/g' /etc/named.conf
sed -i 's/allow-query     { localhost; };/allow-query     { any; };/g' /etc/named.conf
sed -i 's/recursion yes;/recursion no;/g' /etc/named.conf

domain_chk=$(cat /etc/named.rfc1912.zones | grep $domain)
if [[ ${#domain_chk} != 0 ]];
then
        echo "Already registration domain"
else
        echo -n "Do you have SLAVE DNS (0:no,1:yes) : "
        read cho
        if [[ $cho != 0 ]];
        then
                slave=”192.168.1.107”

                echo -e '\nzone "'$domain'" IN {' >> /etc/named.rfc1912.zones
                echo -e '\ttype master;' >> /etc/named.rfc1912.zones
                echo -e '\tfile "'$domain'.zone";' >> /etc/named.rfc1912.zones
                echo -e '\talso-notify { '$slave'; };' >> /etc/named.rfc1912.zones
                echo -e '\tallow-transfer { '$slave'; };\n};' >> /etc/named.rfc1912.zones
        else

                echo -e '\nzone "'$domain'" IN {' >> /etc/named.rfc1912.zones
                echo -e '\ttype master;' >> /etc/named.rfc1912.zones
                echo -e '\tfile "'$domain'.zone";\n};' >> /etc/named.rfc1912.zones
        fi
        echo "Content Add Done"
        sleep 1
fi

rm -f /var/named/$domain.zone
touch /var/named/$domain.zone
loc=/var/named/$domain.zone
localIp=$(hostname -I | cut -d' ' -f1)

echo '$TTL 1D' >> $loc
echo "@       IN SOA  ns1.$domain.       root(" >> $loc
echo "                                        0       ; serial" >> $loc
echo "                                        60      ; refresh" >> $loc
echo "                                        1H      ; retry" >> $loc
echo "                                        1W      ; expire" >> $loc
echo "                                        3H )    ; minimum" >> $loc
echo "        IN      NS      ns1.$domain." >> $loc
if [[ $cho != 0 ]];
then
        echo "        IN      NS      ns2.$domain." >> $loc
fi
echo "ns1     IN      A       $localIp" >> $loc
if [[ $cho != 0 ]];
then
        echo "ns2     IN      A       $slave" >> $loc
fi

for i in ${host[@]}
do
        echo -n "${i} IP is : "
        read webIp
        echo "${i}     IN      A       $webIp" >> $loc
done

sleep 1
systemctl start named
systemctl enable named
   
