# Debian host

## Follow the INSTALLATION readme
First you have to follow the installation instructions detailed [here](INSTALLATION.md).
When you're done with the ruby installation, go on.

## Needed tools

```shell
sudo apt install git
```

MySQL client
```shell
sudo apt install default-libmysqlclient-dev
```

NodeJS is required for assets compilation:
```shell
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt install -y nodejs
```

## Github setup
Add your hosting server public SSH key to your [Github account](https://github.com/settings/keys).
During the deployment process the server will pull code directory from Github.

## Server setup

### App directory
Create the following directory on the server
`/var/www/ISSKA/NAM/`. This directory is used by the deploy process to store every files related to the NAM application.
You can change this value in the [deploy.rb](config/deploy.rb) file.

### Database
Create the following file and store here your database credentials: `/var/www/ISSKA/NAM/shared/config/database.yml`

Exemple:
```YAML
preproduction:
  adapter: mysql2
  encoding: utf8mb4
  collation: utf8mb4_bin
  database: myDbName
  username: myUserName
  password: myStrongPassword
  host: myDbServer
  port: 3306
```

### Secrets

Create the following file and store here your application secret credentials: `/var/www/ISSKA/NAM/shared/config/secrets.yml`

Exemple:
```YAML
preproduction:
  secret_key_base: 73519f91ee27dc3c6dbaf4a662ee4a38c2fdf5e09c614abd75d6343f3002966f2e184b91aef25a61d177031e40d6828baebbcbb18132fac4585acac83e2e8a37
  my_super_secret: neverGonnaGiveYouUp
```
