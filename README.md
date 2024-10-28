# MoonBattery Project

This repository is for the MoonBattery project, a Ruby on Rails application with PostgreSQL as its database. The project includes a monitoring setup using Zabbix to ensure uptime and performance monitoring.

## Getting Started

These instructions will help you set up the MoonBattery project on your local machine for development and testing.

### Prerequisites

- Ruby
- PostgreSQL
- MySQL (for Zabbix setup)
- Zabbix (optional monitoring tool)
- Apache or Nginx (if required for Zabbix frontend)

### Installation

#### 1. Create a New Rails Project with PostgreSQL

```bash
rails new moonBattery -d postgresql

rake db:create #To create a database

rails generate model Storage macaddress:string serialnumber:integer lastcontact:string #generate Storage Model

rails generate model Configurations macaddress:string  configuration:string value:string #generate Storage Model

```
I Add this line of code to the Storage Model to make sure that the macaddress is unqiue
```
validates :macaddress, uniqueness: true
```
Then add a unique index for the macaddress
```
rails generate migration AddUniqueIndexToMacaddress
```
Then, in the generated migration file add:
```
def change
  add_index :storages, :macaddress, unique: true
end
```
next you can start migration:
```
rails db:migrate

rails generate controller storage

rails generate controller configuration

```

To access your Database with Postgres 
```
sudo -u postgres psql

\c moon_battery_development
#this is the default database I am using based on the database.yml

```
Zabbix Monitoring Setup
Follow these steps to install and configure Zabbix for monitoring your Rails backend.

Install Zabbix
Update packages and install Zabbix server and agent:

```
sudo apt update
sudo apt install zabbix-server zabbix-agent zabbix-frontend-php
```
Configure Zabbix agent by editing the configuration file:

```
sudo nano /etc/zabbix/zabbix_agentd.conf
```
Set the following parameters to your server's IP:

```
Server=YOUR_ZABBIX_SERVER_IP
ServerActive=YOUR_ZABBIX_SERVER_IP
```
Restart Zabbix agent:

```
sudo systemctl restart zabbix-agent
```
Log in to the Zabbix web interface (default is http://your-server-ip/zabbix).

Set Up Web Server for Zabbix
If you need a web server, you can set up Apache:

Install Apache:

```
sudo apt install apache2
```
Copy Zabbix files if not in /var/www/html:

```
sudo cp -R /usr/share/zabbix /var/www/html/
```
Restart Apache:

```
sudo systemctl restart apache2
```

Now the setup is ready.

Register endpoint needs macaddress passed as a parameter as follows:
http://127.0.0.1:3000/storage/new?```macaddress=abcdefg098```

Ping endpoint needs also the macaddress as a parameter as follows:
http://127.0.0.1:3000/ping/```macaddress=abcdefg098```
I used Zabbix to trigger a periodic ping to the backend every 1m

Configuration endpoint needs the macaddress and 1 or more configuration of type key-value pair separated with ```;``` and defined in this format ```Key:Value``` as follows:
http://127.0.0.1:3000/configuration/add?```macaddress=abcdefg098```&```configurations=Brightness:50;Color:Green;Timer:Off;Sound:Off```


