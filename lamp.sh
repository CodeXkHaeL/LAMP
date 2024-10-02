#!/bin/bash
words=("This is the summary of the script" 
       "* Updating the package list" 
       "* Installing Apache2" 
       "* Installing MySQL database" 
       "* Installing PHP with extensions" 
       "* Installing phpMyAdmin and configuration" 
       "* Enabling the mbstring extension for PHP" 
       "* Creating the database and tables for testing and creating an account with admin access" 
       "* Creating a database connection for web testing")

for word in "${words[@]}"; do
    echo "$word"    
    sleep 1.5
done
sleep 2
clear


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

#Creating Databse and table for database testing and creating account with admin access 
read -p "please enter you're username for mysql login:" username
read -sp "please enter youre password:" password
sudo mysql <<EOF
CREATE USER '$username'@'localhost' IDENTIFIED BY '$pass';
GRANT ALL PRIVILEGES ON *.* TO '$username'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
clear
echo "Creating database connection for web test later.."
sleep 2
clear



# creating db connection for web test
directory="/var/www/html/"
sudo cat <<EOF> "$directory/db.php"
<?php
\$host = 'localhost';
\$user = '$username';
\$pass = '$password';
\$dbname = 'test_db';

// Create connection
\$conn = new mysqli(\$host, \$user, \$pass,\$dbname);

// Check connection
if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}
?>
EOF
echo "file added sucessfully";
sleep 2
clear
echo "LAMP stack and phpMyAdmin installation complete! Enjoy your setup!"
