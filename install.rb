Dir[File.join(File.dirname(__FILE__), '/lib/*.rb')].each { |f| require f }
Dir[File.join(File.dirname(__FILE__), '/packages/*.rb')].each { |f| require f }

# Configuration
nodes_path = File.join(File.dirname(__FILE__), 'nodes.yml')
raise "\nCould not load NODES configuration: #{nodes_path} not found" unless File.exists?(nodes_path)
NODES = YAML::load(File.open(nodes_path))
puts "nodes.yml: #{NODES}"

NODES.each do |node|
  if node['enabled']
    puts "Node #{node['name']} is enabled"

    # Reqire all packages
    policy :provision, :roles => :provision do
      node['packages'].each do |package|
        requires package
      end
    end

    # Provision required packages into current node
    deployment do
      delivery :capistrano do
        recipes 'Capfile'
        role :provision, node['ip']
        set :user, node['user']
        set :password, node['password']
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
