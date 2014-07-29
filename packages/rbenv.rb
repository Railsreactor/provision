package :rbenv do
  description 'Install rbenv Ruby version manager'

  requires :install_rbenv, :install_ruby_build, :install_ruby, :add_rbenv_bundler
end

package :install_rbenv do
  description 'Install rbenv Ruby version manager'

  requires :git

  runner "true; git clone git://github.com/sstephenson/rbenv.git ~/.rbenv"
  push_text 'export PATH="$HOME/.rbenv/bin:$PATH"', "~/.profile"
  push_text 'eval "$(rbenv init -)"', "~/.profile"
  # runner "chown #{user} #{home_path}/.bash_profile"
  # runner "chmod -R g+rwxXs ~/.rbenv"

  verify do
    has_executable "~/.rbenv/bin/rbenv"
  end
end

package :install_ruby_build do
  description 'Install lib to build rubies'

  requires :git

  runner "rm -rf ~/.rbenv/plugins/ruby-build"
  runner "true; git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

  verify do
    @commands << "~/.rbenv/bin/rbenv install|grep Usage"
  end
end

package :ruby_dependencies do
  description 'Setup Ruby dependencies'
  apt 'libssl-dev zlib1g-dev libreadline-dev libpq-dev libyaml-dev build-essential flex gettext libxslt1-dev libxml2-dev' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'libxml2-dev'
    has_apt 'libxslt1-dev'
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

  runner 'true; CONFIGURE_OPTS="--disable-install-doc" ~/.rbenv/bin/rbenv install -f -v 2.1.2', sudo: false
  runner 'true; touch ~/.rbenv/global'
  push_text '2.1.2', '~/.rbenv/global'
  runner 'true; echo "gem: --no-ri --no-rdoc\n" > ~/.gemrc'

  verify do
    @commands << '~/.rbenv/bin/rbenv versions | grep 2.1.2'
    file_contains '~/.rbenv/global', '2.1.2'
  end
end

package :add_rbenv_bundler do
  runner "true; ~/.rbenv/versions/2.1.2/bin/gem install bundler --no-ri --no-rdoc"
  runner "true; ~/.rbenv/bin/rbenv rehash"

  verify do
    @commands << "~/.rbenv/versions/2.1.2/bin/gem list | grep bundler"
  end
end
