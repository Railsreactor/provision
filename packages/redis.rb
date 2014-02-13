package :redis_apt do
  requires :ppa
  apt_list    = '/etc/apt/sources.list.d/rwky-redis-precise.list'

  runner 'sudo add-apt-repository -y ppa:rwky/redis'
  runner 'sudo apt-get update'

  verify do
    file_contains apt_list, 'ppa.launchpad.net/rwky/redis/ubuntu'
  end
end

package :redis do
  requires :redis_apt

  apt 'redis-server'

  verify do
    has_apt 'redis-server'
  end
end
