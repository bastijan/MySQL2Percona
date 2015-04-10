# MySQL2Percona
Simple bash script to upgrade MySQL to Percona database (version 5.5)

This script use mysqldump.sh script (https://github.com/MiteshShah/admin) for database backup.

If you want install other Percona server version please edit last line in my2percona.sh:

apt-get install percona-server-server-5.5 percona-server-client-5.5
to
apt-get install percona-server-server-5.6 percona-server-client-5.6


