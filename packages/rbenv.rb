package :rbenv do
  description 'Install rbenv Ruby version manager'

  requires :install_rbenv, :install_ruby_build, :install_ruby, :add_rbenv_bundler
end

package :install_rbenv do
  description 'Install rbenv Ruby version manager'

  requires :git

  runner 'sudo -u deployer -i git clone git://github.com/sstephenson/rbenv.git /home/deployer/.rbenv'
  push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', '/home/deployer/.bash_profile'
  push_text 'eval "$(rbenv init -)"', '/home/deployer/.bash_profile'
  runner 'chown deployer /home/deployer/.bash_profile'
  runner 'chmod -R g+rwxXs /home/deployer/.rbenv'

  verify do
    has_executable '/home/deployer/.rbenv/bin/rbenv'
  end
end

package :install_ruby_build do
  description 'Install lib to build rubies'

  requires :git

  runner 'rm -rf /home/deployer/.rbenv/plugins/ruby-build'
  runner 'git clone https://github.com/sstephenson/ruby-build.git /home/deployer/.rbenv/plugins/ruby-build'

  verify do
    @commands << '/home/deployer/.rbenv/bin/rbenv install|grep Usage'
  end
end

package :ruby_dependencies do
  description 'Setup Ruby dependencies'
  apt 'libssl-dev zlib1g-dev libreadline-dev libpq-dev libyaml-dev build-essential flex gettext' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'libssl-dev'
    has_apt 'zlib1g-dev'
    has_apt 'libreadline-dev'
    has_apt 'libpq-dev'
    has_apt 'libyaml-dev'
    has_apt 'build-essential'
    has_apt 'flex'
    has_apt 'gettext'
  end
end

package :install_ruby do
  description 'Install Ruby'

  requires :install_ruby_build, :ruby_dependencies

  runner 'CONFIGURE_OPTS="--disable-install-doc" /home/deployer/.rbenv/bin/rbenv install -f -v 2.0.0-p353'
  push_text '2.0.0-p353', '/home/deployer/.rbenv/global'

  verify do
    @commands << 'sudo -u deployer -i /home/deployer/.rbenv/bin/rbenv versions | grep 2.0.0-p353'
    file_contains '/home/deployer/.rbenv/global', '2.0.0-p353'
  end
end

package :add_rbenv_bundler do
  runner '/home/deployer/.rbenv/versions/2.0.0-p353/bin/gem install bundler --no-ri --no-rdoc'
  runner '/home/deployer/.rbenv/bin/rbenv rehash'

  verify do
    @commands << '/home/deployer/.rbenv/versions/2.0.0-p353/bin/gem list | grep bundler'
  end
end
