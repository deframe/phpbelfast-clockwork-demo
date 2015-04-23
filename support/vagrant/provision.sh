#!/bin/bash

echo -e "\n# Setting timezone...\n"

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime

###############################################################################

echo -e "\n# Updating packages...\n"

apt-get -y update

###############################################################################

echo -e "\n# Installing packages...\n"

apt-get -y install debconf-utils
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get -y install curl unzip wget git imagemagick mysql-server apache2 php5 ssmtp
apt-get -y install libapache2-mod-auth-mysql
apt-get -y install php5-apcu php5-curl php5-gd php5-imagick php5-intl php5-mcrypt php5-mysqlnd php5-pspell libssh2-php php5-sqlite php5-xdebug php5-xsl php-pear

###############################################################################

echo -e "\n# Configuring Apache & default site...\n"

echo -e "\nServername localhost" >> /etc/apache2/apache2.conf
rm /etc/apache2/sites-available/*
rm /etc/apache2/sites-enabled/*
cp -f /vagrant/support/vagrant/templates/etc/apache2/sites-available/default.conf /etc/apache2/sites-available/default.conf
a2ensite default.conf

###############################################################################

echo -e "\n# Configuring Apache mods...\n"

a2enmod rewrite auth_mysql
echo "Auth_MySQL_Info localhost root root" >> /etc/apache2/mods-enabled/auth_mysql.load

###############################################################################

echo -e "\n# Configuring PHP...\n"

for PHP_INI_FILE in $(find /etc/php5 -name php.ini)
do
    sed -i -r "s/^;?(date\.timezone)\s*=.*$/\1 = Europe\/London/" $PHP_INI_FILE
    sed -i -r "s/^;?(error_reporting)\s*=.*$/\1 = E_ALL \& ~E_NOTICE \& ~E_DEPRECATED/" $PHP_INI_FILE
    sed -i -r "s/^;?(display_errors)\s*=.*$/\1 = On/" $PHP_INI_FILE
    sed -i -r "s/^;?(upload_max_filesize)\s*=.*$/\1 = 200M/" $PHP_INI_FILE
    sed -i -r "s/^;?(post_max_size)\s*=.*$/\1 = 200M/" $PHP_INI_FILE
    sed -i -r "s/^;?(session\.save_path)\s*=.*$/\1 = \"\/tmp\"/" $PHP_INI_FILE
done
mkdir /usr/share/phpinfo
echo "<?php phpinfo();" > /usr/share/phpinfo/phpinfo.php
cp /vagrant/support/vagrant/templates/etc/apache2/conf-available/phpinfo.conf /etc/apache2/conf-available/phpinfo.conf
a2enconf phpinfo.conf

###############################################################################

echo -e "\n# Configuring PHP extensions...\n"

sed -i "s/defaults[(]'USE_AUTHENTICATION',1[)];/defaults('USE_AUTHENTICATION',0);/g" /usr/share/doc/php5-apcu/apc.php
cp /vagrant/support/vagrant/templates/etc/apache2/conf-available/apc.conf /etc/apache2/conf-available/apc.conf
a2enconf apc.conf
cat << EOF | tee -a /etc/php5/mods-available/xdebug.ini
xdebug.remote_enable = on
xdebug.remote_handler = dbgp
xdebug.remote_connect_back = on
EOF
php5enmod mcrypt

###############################################################################

echo -e "\n# Configuring MySQL...\n"

sed -i "s/^skip-external-locking/#skip-external-locking/g" /etc/mysql/my.cnf
sed -i "s/^bind-address/#bind-address/g" /etc/mysql/my.cnf
mysql --user=root --password=root -e "DELETE FROM mysql.user WHERE (User = 'root' AND Host <> 'localhost') OR (User = '')";
mysql --user=root --password=root -e "UPDATE mysql.user SET Host = '%' WHERE User = 'root'";
mysql --user=root --password=root -e "FLUSH PRIVILEGES";
mysqladmin --user=root --password=root create vagrant

###############################################################################

echo -e "\n# Installing Mailhog...\n"

wget --quiet -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v0.1.5/MailHog_linux_386
chmod +x /usr/local/bin/mailhog
cp /vagrant/support/vagrant/templates/etc/init/mailhog.conf /etc/init/mailhog.conf
mkdir /etc/ssmtp
cp /vagrant/support/vagrant/templates/etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf
service mailhog start

###############################################################################

echo -e "\n# Installing and configuring phpMyAdmin...\n"

cd /usr/share/
wget --quiet http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.2.2/phpMyAdmin-4.2.2-all-languages.zip
unzip -q phpMyAdmin-4.2.2-all-languages
rm phpMyAdmin-4.2.2-all-languages.zip
rm -rf ./phpmyadmin
mv ./phpMyAdmin-4.2.2-all-languages ./phpmyadmin
mysql --user=root --password=root < ./phpmyadmin/examples/create_tables.sql
cp /vagrant/support/vagrant/templates/usr/share/phpmyadmin/config.inc.php /usr/share/phpmyadmin/config.inc.php
cp /vagrant/support/vagrant/templates/etc/apache2/conf-available/phpmyadmin.conf /etc/apache2/conf-available/phpmyadmin.conf
a2enconf phpmyadmin.conf

###############################################################################

echo -e "\n# Installing VM admin front-end...\n"

cp -r /vagrant/support/vagrant/resources/usr/share/vm-admin /usr/share
cp /vagrant/support/vagrant/templates/etc/apache2/conf-available/vm-admin.conf /etc/apache2/conf-available/vm-admin.conf
a2enconf vm-admin.conf

###############################################################################

echo -e "\n# Restarting services...\n"

service apache2 restart
service mysql restart

###############################################################################

echo -e "\n# Provisioning complete!\n"