default_run_options[:pty] = true

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load plugin }

set :ssh_options, {:forward_agent => true}
set :use_sudo, true

default_run_options[:pty] = true

if ENV['NODE'] == 'vagrant'
  ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/authorized_keys"]
end

