Provision
=========

[![Join the chat at https://gitter.im/Railsreactor/provision](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Railsreactor/provision?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This project helps with provisioning for Ubuntu servers with minimal efforts using Sprinkle https://github.com/sprinkle-tool/sprinkle

## Set up

Set up local ruby gemset and gems from Gemfile `bundle install`

## Provision

### Server

1. Set up an IP address, roles and packages in `nodes.yml`. You can use an example for this `cp nodes.yml.example nodes.yml`. It contains all the options available.
2. Run setup stage to set up deployer user (usually `ubuntu`), automatic security upgrades and enable 2 Gb swap `STAGE=setup ruby provision.rb`. You can skip swap creation just by adding `NO_SWAP=true` . In case `root` user does not have password, in `nodes.yml` leave `root_password` blank.
3. Provision your server `ruby provision.rb`

### Vagrant

Make sure `name: vagrant` node is `enabled: true` in `nodes.yml`

Set up VirtualBox https://www.virtualbox.org/wiki/Downloads

Set up Vagrant https://www.vagrantup.com/downloads.html

Check out settings in `Vagrantfile`

Run Vagrant `vagrant destroy -f && vagrant up`

Run provision to set up deployer user `STAGE=setup ruby provision.rb`

Run provision `ruby provision.rb`

All-together `vagrant destroy -f && vagrant up && STAGE=setup ruby provision.rb && ruby provision.rb`

## Contributing

Please create new package, test it and send pull request

## Tested environments

* Ubuntu: 16.04 LTS, 14.04 LTS, 12.04 LTS
* Ruby: 2.4.1, 2.3.1, 2.3.0, 2.2.x, 2.1.5
* Postgres: 9.6, 9.5, 9.4, 9.3

## Tested cloud providers

* DigitalOcean: works smoothly
* Google Compute Engine: use Ubuntu 16.04 LTS. ssh with your user, `sudo su` and then add your key to `/home/ubuntu/.ssh/authorized_keys` manually before doing `ruby provision.rb`
* Azure: update TCP timeout setting

###

* Vagrant: 1.8.x, 1.7.x
* VirtualBox: 5.0.x

## License

MIT
