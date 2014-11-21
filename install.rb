Dir[File.join(File.dirname(__FILE__), '/lib/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '/packages/*.rb')].each { |f| require f }

# Configuration
nodes_path = File.join(File.dirname(__FILE__), 'nodes.yml')
NODES = YAML::load(File.open(nodes_path))
NODE_CONFIG = NODES[ENV['NODE']]

if NODE_CONFIG['enabled']
  if ENV['STAGE'] == 'setup'
    policy :setup, :roles => :setup do
      requires :setup_system
    end

    deployment do
      delivery :capistrano do
        recipes 'Capfile'

        role :setup, NODE_CONFIG['ip']
        set :user, NODE_CONFIG['root_user']
        set :password, NODE_CONFIG['root_password']
      end
    end
  else
    policy :provision, :roles => :provision do
      NODE_CONFIG['packages'].each do |package|
        requires package
      end
    end

    deployment do
      delivery :capistrano do
        recipes 'Capfile'

        role :provision, NODE_CONFIG['ip']
        set :user, NODE_CONFIG['deployer_user']
        set :pty, true
      end

      # source based package installer defaults
      source do
        prefix '/usr/local'
        archives '/usr/local/sources'
        builds '/usr/local/build'
      end
    end
  end
end
