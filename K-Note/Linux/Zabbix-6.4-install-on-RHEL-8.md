# Zabbix 6.0 LTS install on RHEL8

https://www.zabbix.com/download

## Method (1) Installation with Postgres

```
rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-4.el8.noarch.rpm
dnf clean all

dnf install zabbix-server-pgsql zabbix-web-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent -y

systemctl status postgres
sudo -u postgres createuser --pwprompt zabbix  # pw: password
sudo -u postgres createdb -O zabbix zabbix

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

```
vi /etc/zabbix/zabbix_server.conf
	> DBPassword=password

vi /var/lib/pgsql/12/data/pg_hba.conf
	> host all all 127.0.0.1/32 md5
	> host all all ::1/128 md5
```

```
systemctl restart zabbix-server zabbix-agent httpd php-fpm
systemctl enable zabbix-server zabbix-agent httpd php-fpm
tail /var/log/zabbix/zabbix_server.log 

systemctl status firewalld
firewall-cmd --add-service=http --permanent && firewall-cmd --reload
```

- http://your_ip_address/zabbix
	- port: 80
	- hostname: rhel-8.parallel
	- name: Admin
	- pass: zabbix

---

## Method (2) Installation with MySQL

```
vi /etc/selinux/config
	> SELINUX=permissive
reboot

dnf install mysql-server -y
systemctl status mysqld
systemctl enable mysqld --now

/usr/bin/mysql_secure_installation
	> VALIDATE PASSWORD component > no
	> password = mysql
	> Remove anonymous user > yes
	> Disallow root login remotely > yes
	> Remove test database > yes
	> Reload > yes
```

```
rpm -Uvh https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-4.el8.noarch.rpm
dnf clean all

dnf install zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent -y
```

Configure MySQL
```
mysql -u root -p  > pw:mysql
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by 'password';
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix

mysql -u root -p > pw:mysql
mysql> show databases;
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
```

```
vi /etc/zabbix/zabbix_server.conf
	> DBPassword=password

systemctl restart zabbix-server zabbix-agent httpd php-fpm
systemctl enable zabbix-server zabbix-agent httpd php-fpm

systemctl status firewalld
firewall-cmd --add-service=http --permanent && firewall-cmd --reload
```

- http://your_ip_address/zabbix
	- port: 0
	- hostname: rhel-8.parallel
	- name: Admin
	- pass: zabbix
