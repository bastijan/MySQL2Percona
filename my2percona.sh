#!/bin/bash -e
# MySQL to Percona upgrade script
# Debian and Ubuntu
#
# Sasa Jovanovic
# http://adbuka.com

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# Take Database Dump
# Database dump will be saved in /var/www/mysqldump
wget https://raw.githubusercontent.com/MiteshShah/admin/master/backup/mysqldump.sh


output_var=$(bash mysqldump.sh)

if echo $output_var | grep -wi "error\|not\|warning\|cannot" ; then
  echo "Backup Failed"
  exit 1
else
  echo "Backup Finished"
fi

echo "$output_var"

#run both 
service mysql stop
/etc/init.d/mysql stop 

#backup files
mkdir -p /backup/mysql/data
cp -av /etc/mysql /backup
cp -av /var/www/mysqldump /backup/mysql
cp -av /var/lib/mysql/ /backup/mysql/data
apt-get purge mysql-server*
apt-get autoremove

#install percona server
apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A

#Add to /etc/apt/sources.list
echo "deb http://repo.percona.com/apt "$(lsb_release -sc)" main"  >> /etc/apt/sources.list.d/percona.list
echo "deb-src http://repo.percona.com/apt "$(lsb_release -sc)" main" >> /etc/apt/sources.list.d/percona.list

#install percona server
apt-get update
apt-get install percona-server-server-5.5 percona-server-client-5.5
