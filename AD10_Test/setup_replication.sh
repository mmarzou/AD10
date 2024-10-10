#!/bin/bash

# Wait for the databases to initialize
sleep 30

# Configure Master
docker cp db_master.cnf db_master:/etc/mysql/conf.d/db_master.cnf
docker exec db_master bash -c "chown mysql:mysql /etc/mysql/conf.d/db_master.cnf"
docker restart db_master

# Configure Slave
docker cp db_slave.cnf db_slave:/etc/mysql/conf.d/db_slave.cnf
docker exec db_slave bash -c "chown mysql:mysql /etc/mysql/conf.d/db_slave.cnf"
docker restart db_slave

# Wait for restart
sleep 20

# Set up replication user on Master
docker exec db_master mysql -uroot -prootpassword -e "GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%' IDENTIFIED BY 'replicatorpassword'; FLUSH PRIVILEGES;"
MASTER_STATUS=$(docker exec db_master mysql -uroot -prootpassword -e "SHOW MASTER STATUS\G")
CURRENT_LOG=$(echo "$MASTER_STATUS" | grep File: | awk '{print $2}')
CURRENT_POS=$(echo "$MASTER_STATUS" | grep Position: | awk '{print $2}')

# Configure Slave to replicate from Master
docker exec db_slave mysql -uroot -prootpassword -e "CHANGE MASTER TO MASTER_HOST='db_master', MASTER_USER='replicator', MASTER_PASSWORD='replicatorpassword', MASTER_LOG_FILE='$CURRENT_LOG', MASTER_LOG_POS=$CURRENT_POS;"
docker exec db_slave mysql -uroot -prootpassword -e "START SLAVE;"
