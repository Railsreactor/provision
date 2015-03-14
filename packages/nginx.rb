package :nginx do
  description "Install nginx"
  requires :nginx_apt

  apt 'nginx'

  runner 'sudo rm -f /etc/nginx/conf.d/default.conf'

  verify do
    has_apt 'nginx'
  end
end

package :nginx_apt do
  apt_list    = '/etc/apt/sources.list.d/nginx.list'
  apt_source  = "deb http://nginx.org/packages/ubuntu/ `lsb_release -c -s` nginx\n"

  runner "echo \"#{apt_source}\" | sudo tee #{apt_list}" do
    pre :install, 'true && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62'
    post :install, 'sudo apt-get update'
    post :install, 'sudo apt-get purge nginx*'
  end

  verify do
    file_contains apt_list, 'nginx'
  end
end
