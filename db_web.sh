#!/bin/bash
echo "creating a database table and copying web test...."
sleep 1
sudo rm /var/www/html/index.html
sudo cp -r sample_login_web/* /var/www/html/
sudo mysql <<EOF
CREATE DATABASE test_db;
USE test_db;
CREATE TABLE users (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    time_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF
echo "done enjoy!!!!!"
sleep 2
