require 'yaml'

Dir[File.join(File.dirname(__FILE__), '/lib/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '/packages/*.rb')].each { |f| require f }

# Configuration
nodes_path = File.join(File.dirname(__FILE__), 'nodes.yml')
NODES = YAML.load(File.open(nodes_path))
NODE_CONFIG = NODES[ENV['NODE']]

if NODE_CONFIG['enabled']
  if ENV['STAGE'] == 'setup'
    policy :setup, roles: :setup do
      requires :setup_system, deployer_user: NODE_CONFIG['deployer_user']
      requires :swap, deployer_user: NODE_CONFIG['deployer_user'], swap_size: NODE_CONFIG['swap_size'] unless ENV['NO_SWAP']
    end

    deployment do
      delivery :capistrano do
        recipes 'Capfile'

        role :setup, NODE_CONFIG['ip']
        set :user, NODE_CONFIG['root_user']
        set :password, NODE_CONFIG['root_password'] if NODE_CONFIG['root_password']
        set :ssh_options, forward_agent: true
      end
    end
  else
    policy :provision, roles: :provision do
      NODE_CONFIG['packages'].each do |package, options|
        options ||= {}
        requires package, options.symbolize_keys
      end
    end

    deployment do
      delivery :capistrano do
        recipes 'Capfile'

        role :provision, NODE_CONFIG['ip']
        set :user, NODE_CONFIG['deployer_user']
        set :pty, true
        set :ssh_options, forward_agent: true
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
