#!/bin/bash

# This script creates virtual hosts.
# you should put it under /usr/local/bin/
# and run it with sudo newvhost

# Set the path to your localhost
www=/home/sopkov/www
echo "Enter directory name under $www"
read sn

mkdir $www/$sn

# Create the file with VirtualHost configuration in /etc/apache2/site-available/
echo "<VirtualHost *:80>
        DocumentRoot /home/sopkov/www/$sn/
        ServerName $sn
        ServerAlias www.$sn
        <Directory /home/sopkov/www/$sn/>
			Options +Indexes +FollowSymLinks
			AllowOverride All
			Require all granted
        </Directory>

ErrorLog \${APACHE_LOG_DIR}/$sn-error.log
CustomLog \${APACHE_LOG_DIR}/$sn-access.log combined

</VirtualHost>




" > /etc/apache2/sites-available/$sn.conf


# Add the host to the hosts file
echo 127.0.0.1 $sn www.$sn >> /etc/hosts


# Enable the site
a2ensite $sn


# Reload Apache2
/etc/init.d/apache2 restart

echo "Your new site is available at http://$sn"
