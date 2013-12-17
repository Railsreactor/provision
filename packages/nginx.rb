package :nginx do
  apt 'nginx' do
    pre :install, ['aptitude update']
  end

  runner 'sudo rm /etc/nginx/sites-enabled/default'

  verify do
    has_apt 'nginx'
  end
end