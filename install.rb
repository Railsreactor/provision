Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/packages/*.rb'].each { |f| require f }

policy :app_server, :roles => :rails do
  requires :ruby
end

policy :db_server, :roles => :db do
  requires :postgres_db
end

deployment do
  delivery :capistrano do
    recipes 'Capfile'

    role :rails, '192.168.100.33' # Vagrant IP address by default
    role :db,    '192.168.100.33' # Vagrant IP address by default

    if ENV['STAGE'] == 'vagrant'
      set :user, 'vagrant'
      set :password, 'vagrant'
    else
      set :user, 'provisioner'
    end
  end

  # source based package installer defaults
  source do
    prefix '/usr/local'
    archives '/usr/local/sources'
    builds '/usr/local/build'
  end
end