# vi ~/dbset3.sh
#!/bin/bash
masterIp=$(grep masterIp= dbset2.sh | cut -d'=' -f2)
slaveIp=$(grep slaveIp= dbset2.sh | cut -d'=' -f2)
log=$(grep log= dbset2.sh | cut -d'=' -f2)
pos=$(grep pos= dbset2.sh | cut -d'=' -f2)
sed -i 's/'$log'/@File@/g' dbset2.sh
sed -i 's/'$pos'/@Pos@/g' dbset2.sh
sed -i 's/'$masterIp'/@masterIp@/g' dbset2.sh
sed -i 's/'$slaveIp'/@slaveIp@/g' dbset2.sh