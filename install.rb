Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/packages/*.rb'].each { |f| require f }

if ENV['SETUP'] == '1'
  policy :setup, :roles => :setup do
    requires :create_deployer_user
  end

  deployment do
    delivery :capistrano do
      recipes 'Capfile'

      role :setup, '192.168.100.33'

      if ENV['STAGE'] == 'vagrant'
        set :user, 'vagrant'
        set :password, 'vagrant'
      else
        set :user, 'root'
      end
    end
  end
else
  policy :app_server, :roles => :rails do
    requires :rbenv
  end

  policy :db_server, :roles => :db do
    requires :postgres_db
  end

  deployment do
    delivery :capistrano do
      recipes 'Capfile'

      set :user, 'deployer'

      role :rails,        '192.168.100.33' # Vagrant IP address by default
      role :db,           '192.168.100.33' # Vagrant IP address by default
    end

    # source based package installer defaults
    source do
      prefix '/usr/local'
      archives '/usr/local/sources'
      builds '/usr/local/build'
    end
  end
end

