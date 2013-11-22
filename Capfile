default_run_options[:pty] = true

load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

set :use_sudo, true

if ENV['STAGE'] == "local"
  ssh_options[:keys] = ["#{ENV['HOME']}/.vagrant.d/insecure_private_key"]
end