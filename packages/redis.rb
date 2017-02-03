package :redis do
  description 'Install Redis'
  requires :redis_repo
  requires :redis_server
  requires :update_redis_conf
end

package :redis_repo do
  requires :ppa
  runner 'sudo add-apt-repository -y ppa:rwky/redis'
end

package :redis_server do
  apt 'redis-server' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'redis-server'
  end
end

package :update_redis_conf do
  runner "sudo sed -i 's/# bind 127.0.0.1/bind 127.0.0.1/g' /etc/redis/redis.conf"
  runner 'sudo service redis-server restart'

  verify do
    @commands << "cat /etc/redis/redis.conf |grep -v '# bind 127.0.0.1'|grep 'bind 127.0.0.1'"
  end
end
