#!/bin/sh

# Check if the required environment variables are set
if  [ -z "$SQL_ROOT_PASSWORD" ] || [ -z "$SQL_USER" ] || [ -z "$SQL_PASSWORD" ] || [ -z "$SQL_DATABASE" ]; then
	echo "Missing environment variables";
	exit 1;
fi

# Initialize the MySQL data directory and create the system tables
# --user : The user that will own the data directory
# --datadir : The directory where the data will be stored
# Initialize the MySQL data directory and create the system tables
# if [ ! -d "/var/lib/mysql/mysql" ]; then
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql
# fi
# Initialize the MySQL data directory and create the system tables
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    # Initialize the database
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm

    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        echo "Error: Temporary file could not be created"
        exit 1
    fi
fi

mkdir -p /run/mysqld /run/mysql /var/lib/mysql /var/log/mysql/
chown -R mysql:mysql /run/mysqld /run/mysql /var/lib/mysql /var/log/mysql/
chmod -R 755 /var/log/mysql/

# Start the MySQL server
echo "Starting MariaDB server..."
mysqld --user=mysql --datadir=/var/lib/mysql &
# Get the pid of the MySQL server
pid=$!

# Wait for the database to start
until mysqladmin ping -u root -p${SQL_ROOT_PASSWORD}; do
	echo "Waiting for MariaDB to start...";
	sleep 1;
done

#Check if the socket file exists
if [ ! -S /run/mysqld/mysqld.sock ]; then
    echo "Error: MariaDB socket file not found!"
    ls -l /run/mysqld
    exit 1
fi

# Create the database and user
echo "Creating database and user..."
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${SQL_USER}' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO '${SQL_USER}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Shutdown the database and restart it on foreground
kill "$pid"
wait "$pid"
echo "Restarting MariaDB in foreground..."
exec mysqld --user=mysql 