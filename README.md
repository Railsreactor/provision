## Provision

Project helps provision servers with minimal efforts using Sprinkle https://github.com/sprinkle-tool/sprinkle

## Set up and test provisioning locally

Set up local ruby gemset and gems from Gemfile `bundle install`

Set up VirtualBox 4.2 https://www.virtualbox.org/wiki/Download_Old_Builds_4_2

Set up Vagrant http://downloads.vagrantup.com/tags/v1.3.5

Check out settings in `Vagrantfile`

Run Vagrant `vagrant destroy -f && vagrant up`

Test setup (create users etc) provision `SETUP=1 STAGE=vagrant sprinkle -s install.rb -v`

Test provision (install software) `STAGE=vagrant sprinkle -s install.rb -v`

## Provision existing server

Set up IP address, roles and packages in `install.rb`

Run provision `SETUP=1 sprinkle -s install.rb -v`
