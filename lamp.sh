#!/bin/bash
# Display a welcome message and start the installation process
echo "Automating the LAMP stack installation with phpMyAdmin!"
sleep 2
clear


echo "Updating package list..."
sleep 2
sudo apt update
echo "Update complete."
sleep 2
clear


echo "Installing Apache2..."
sleep 2
sudo apt install -y apache2
sleep 2
clear
echo "Apache2 installation complete!"
sleep 2
clear


echo "Installing MySQL server..."
sleep 2
sudo apt install -y mysql-server
clear
echo "MySQL server installation complete!"
sleep 2
clear

echo "Installing PHP and necessary extensions..."
sleep 2
sudo apt install -y php php-mbstring php-zip php-gd php-json php-curl
echo "now php is done!!!"
sleep 2
clear
echo "PHP installation complete!"
sleep 2
clear


echo "Installing phpMyAdmin..."

echo "phpmyadmin phpmyadmin/reconfigure-webserver select apache2" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | sudo debconf-set-selections
sudo apt install -y phpmyadmin
echo "phpMyAdmin installation complete!"
sleep 2
clear


# Enable the mbstring extension for PHP
sudo phpenmod mbstring
cat <<EOL > /etc/apache2/conf-available/phpmyadmin.conf
Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Require all granted
</Directory>

<Directory /usr/share/phpmyadmin/setup>
    <IfModule mod_authz_core.c>
        <RequireAny>
            Require all granted
        </RequireAny>
    </IfModule>
</Directory>
EOL

sudo a2enconf phpmyadmin
sudo systemctl restart apache2

read -p "please enter you're username for mysql login:" username
read -sp "please enter youre password:" pass
sudo mysql <<EOF
CREATE USER '$username'@'localhost' IDENTIFIED BY '$pass';
GRANT ALL PRIVILEGES ON *.* TO '$username'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
clear
echo "LAMP stack and phpMyAdmin installation complete! Enjoy your setup!"
sleep 2
