require 'yaml'
require 'active_support/all'

# Configuration
nodes_path = File.join(File.dirname(__FILE__), 'nodes.yml')
fail "\nCould not load NODES configuration: #{nodes_path} not found" unless File.exist?(nodes_path)
NODES = YAML.load(File.open(nodes_path))

puts 'Enabled nodes:'
NODES.keys.each do |node_key|
  puts "#{node_key.upcase}: #{NODES[node_key]}" if NODES[node_key]['enabled']
end

NODES.keys.each do |node_key|
  if NODES[node_key]['enabled']
    cmd = "NODE=#{node_key} STAGE=#{ENV['STAGE']} bundle exec sprinkle -s install.rb -v"
    puts "\n#{cmd}\n"
    system(cmd)
  end
end
