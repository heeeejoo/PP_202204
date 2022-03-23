# vi ~/ dbset1.sh
#!/bin/bash
File=$(ansible master -a "mysql -u root -p1 -e 'SHOW MASTER STATUS\G'" -i inventory | grep File | awk '{ print $2 }')
Pos=$(ansible master -a "mysql -u root -p1 -e 'SHOW MASTER STATUS\G'" -i inventory | grep Pos | awk '{ print $2 }')
#masterIp=$(awk '/master/' ~/inventory | awk '{print $2}' | cut -d'=' -f2)
slaveIp=$(awk '/slave/' ~/inventory | awk '{print $2}' | cut -d'.' -f4)
sed -i 's/@File@/'$File'/g' dbset2.sh
sed -i 's/@Pos@/'$Pos'/g' dbset2.sh
#sed -i 's/@masterIp@/'$masterIp'/g' dbset2.sh
sed -i 's/@slaveIp@/'$slaveIp'/g' dbset2.sh


