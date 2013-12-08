## Provision

Project helps provision servers with minimal efforts using Sprinkle https://github.com/sprinkle-tool/sprinkle

## Set up

Set up local ruby gemset and gems from Gemfile `bundle install`

Check out sample configuration in `nodes.yml.example`

Run `cp nodes.yml.example nodes.yml` and make changes for your system in `nodes.yml`

## Set up and test provisioning locally with Vagrant

Make sure `name: vagrant` node is `enabled: true` in `nodes.yml`

Set up VirtualBox 4.2 https://www.virtualbox.org/wiki/Download_Old_Builds_4_2

Set up Vagrant http://downloads.vagrantup.com/tags/v1.3.5

Check out settings in `Vagrantfile`

Run Vagrant `vagrant destroy -f && vagrant up`

Run provision `sprinkle -s install.rb -v`

## Provision existing server

Set up IP address, roles and packages in `nodes.yml`

Run provision `sprinkle -s install.rb -v`

## Contributing

Please create new package, test it and send pull request

## License

MIT
