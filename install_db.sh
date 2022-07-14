#!/bin/bash -eux

echo "installing lamp " >> "/tmp/install_log.txt"
apt update && apt install -y lamp-server^
echo "installing wordpress " >> "/tmp/install_log.txt"
cd /tmp/ && wget https://wordpress.org/latest.tar.gz
tar zxvf latest.tar.gz
echo "Copying the wp-config file" >> "/tmp/install_log.txt"
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
echo "Configure wordpress" >> "/tmp/install_log.txt"
sed -i  -E -e 's/username_here/admin/' -e 's/password_here/password/' -e 's/database_name_here/wordpressdb/'  -e 's/localhost/${db_host}/' /tmp/wordpress/wp-config.php
echo "Copying files " >> "/tmp/install_log.txt"
cp -rf /tmp/wordpress/* /var/www/html/
echo "All Done " >> "/tmp/install_log.txt"