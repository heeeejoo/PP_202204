# vi ~/install.sh
#/bin/bash
rpm -Uvh http://monrepo.gabia.com/repo/centos/noarch/gabmon-repo-1.0.0-2.noarch.rpm
yum -y install gabia_mond
firewall-cmd --permanent --add-service=telnet
firewall-cmd --reload
# echo “ ” 안의 내용은 발급 받은 키를 넣을 것
#echo "[발급받은 키 내용]" | env PATH=$PATH:/usr/local/gabia_mond/bin gabia_mond --start --userkey
