Provision
=========

This project helps with provisioning for Ubuntu servers with minimal efforts using Sprinkle https://github.com/sprinkle-tool/sprinkle

## Set up

Set up local ruby gemset and gems from Gemfile `bundle install`

## Provision

### Server

1. Set up an IP address, roles and packages in `nodes.yml`. You can use an example for this `cp nodes.yml.example nodes.yml`
1. Run provision to set up deployer user and automatic upgrades `STAGE=setup ruby provision.rb`
1. Run provision `ruby provision.rb`

### Vagrant

Make sure `name: vagrant` node is `enabled: true` in `nodes.yml`

Set up VirtualBox 4.2 https://www.virtualbox.org/wiki/Download_Old_Builds_4_2

Set up Vagrant http://downloads.vagrantup.com/tags/v1.3.5

Check out settings in `Vagrantfile`

Run Vagrant `vagrant destroy -f && vagrant up`

Run provision to set up deployer user `STAGE=setup ruby provision.rb`

Run provision `ruby provision.rb`

All-together `vagrant destroy -f && vagrant up && STAGE=setup ruby provision.rb && ruby provision.rb`

## Contributing

Please create new package, test it and send pull request

## Tested environments

* Ruby: 2.1, 2.2
* Postgres: 9.3

## License

MIT
