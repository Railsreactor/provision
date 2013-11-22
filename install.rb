Dir[File.dirname(__FILE__) + '/packages/*.rb'].each {|file| require file }

policy :application_server, :roles => :app do
  requires :ruby
end

deployment do
  # mechanism for deployment
  delivery :capistrano do
    recipes 'Capfile'

    role :app, '192.168.100.33' # Vagrant IP address
    set :user, 'vagrant'
    set :password, 'vagrant'
  end

  # source based package installer defaults
  source do
    prefix '/usr/local'
    archives '/usr/local/sources'
    builds '/usr/local/build'
  end
end