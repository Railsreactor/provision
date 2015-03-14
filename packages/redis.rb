package :redis do
  description 'Install Redis'
  requires :ppa

  runner 'sudo add-apt-repository -y ppa:rwky/redis'

  apt 'redis-server' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'redis-server'
  end
end
