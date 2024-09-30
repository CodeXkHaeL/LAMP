#!/bin/bash
echo "Automate the Lamp installation:with phpmyadmin!!"
sleep 2
clear
echo "lets update first!"
sleep 2
sudo apt update
echo "done update"
sleep 2
clear
echo "lets install apache2"
sleep 2
sudo apt install -y apache2
sleep 2
clear
echo "installation done in apache 2!"
sleep 2
clear
echo "lets install mysql-server!"
sleep 2
sudo apt install -y mysql-server
clear
echo "installation msql-server done!"
sleep 2
clear
echo "lets install php and other pack needed!"
sleep 2
sudo apt install -y php php-mbstring php-zip php-gd php-json php-curl
echo "now php is done!!!"
sleep 2
clear
echo "lets install phpmyadmin"
sleep 2
echo "phpmyadmin phpmyadmin/reconfigure-webserver select apache2" | sudo debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean false" | sudo debconf-set-selections
sudo apt install -y phpmyadmin
echo "doneeeeeee!!!! for phpmyadmin"
sleep 2
clear
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
read -p "please enter you're username for mysql:" username
read -sp "please enter youre password" pass
sudo mysql <<EOF
CREATE USER '$username'@'localhost' IDENTIFIED BY '$pass';
GRANT ALL PRIVILEGES ON *.* TO '$username'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF
clear
echo "now its done enjoy!!!"
sleep 2


