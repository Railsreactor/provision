package :redis do
  description 'Install Redis'
  requires :ppa
  requires :update_redis_conf

  runner 'sudo add-apt-repository -y ppa:rwky/redis'

  apt 'redis-server' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'redis-server'
  end
end

package :update_redis_conf do
  config_file_path = "/etc/redis/redis.conf"
  config_template = File.join(File.dirname(__FILE__), 'configs', 'redis.conf')

  file config_file_path, contents: File.read(config_template), sudo: true

  runner "chmod 755 #{config_file_path}"
  runner 'service redis-server restart'

  verify do
    has_file config_file_path
    has_permission config_file_path, '755'
  end
end
