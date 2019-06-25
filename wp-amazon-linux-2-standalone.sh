#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql -u root << EOF
CREATE DATABASE wordpressdb;
create user wordpressadmin@'%' identified by 'wordpressadmin';
grant all privileges on wordpressdb.* to wordpressadmin@'%';
flush privileges;
exit
EOF
sudo service mariadb restart
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvf latest.tar.gz
sudo mv wordpress/* /var/www/html
sudo chmod -R 755 /var/www/html
sudo chown -R apache.apache /var/www/html
