# MoonBattery Project

This repository is for the MoonBattery project, a Ruby on Rails application with PostgreSQL as its database. The project includes a monitoring setup using Zabbix to ensure uptime and performance monitoring.

![Screenshot 2024-10-29 202038](https://github.com/user-attachments/assets/26e27f05-9514-402c-a9f5-47949062ecec)

![Screenshot 2024-10-29 202112](https://github.com/user-attachments/assets/d6050e23-d969-49c7-8cd6-8fcc243d6864)


## Getting Started

These instructions will help you set up the MoonBattery project on your local machine for development and testing.

### Prerequisites

- Ruby
- PostgreSQL
- MySQL (for Zabbix setup)
- Zabbix
- Apache

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

![Screenshot 2024-10-29 202220](https://github.com/user-attachments/assets/39bcbe73-debc-44c4-abfa-9768bd5c073c)


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

Testing the API using POSTMAN

![Screenshot 2024-10-29 202536](https://github.com/user-attachments/assets/c402c819-e560-435a-91e2-3f814fb83fd9)

![Screenshot 2024-10-29 202442](https://github.com/user-attachments/assets/5a770c0d-c296-4143-b608-8554de1c8ede)


Register endpoint needs macaddress passed as a parameter as follows:
#http://127.0.0.1:3000/storage/new?macaddress=abcdefg098

Ping endpoint needs also the macaddress as a parameter as follows:
#http://127.0.0.1:3000/ping/macaddress=abcdefg098
I used Zabbix to trigger a periodic ping to the backend every 1m

Configuration endpoint needs the macaddress and 1 or more configuration of type key-value pair separated with ';' and defined in this format "Key:Value" as follows:
#http://127.0.0.1:3000/configuration/add?macaddress=abcdefg098&configurations=Brightness:50;Color:Green;Timer:Off;Sound:Off


