### Debian host

#### Needed tools

```shell
sudo apt install wget curl htop dirmngr
```
#### RVM
Install Ruby Version Manager to obtain the most recent ruby version.

```shell
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source /home/user/.rvm/scripts/rvm
```
/!\ Replace `user` by the user you're using /!\

RVM is now installed, you can start installing ruby.

#### Ruby
First install Ruby requirements:

```shell
rvm requirements
```

Install ruby with the wished version like this:
```shell
rvm install 2.5
```
You can list available ruby version as following:
```shell
rvm list known
```
You're done !

```shell
ruby -v
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]
```
