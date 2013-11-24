package :ruby do
  description 'Setup Ruby'
  version '2.0.0'
  patch_level = 'p353'

  source "ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-#{version}-#{patch_level}.tar.gz"

  verify do
    has_executable_with_version 'ruby', "#{version}#{patch_level}"
  end

  requires :ruby_dependencies
end

package :ruby_dependencies do
  description 'Setup Ruby dependencies'
  apt 'libssl-dev zlib1g-dev libreadline-dev libpq-dev build-essential' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'libssl-dev'
    has_apt 'zlib1g-dev'
    has_apt 'libreadline-dev'
    has_apt 'libpq-dev'
    has_apt 'build-essential'
  end
end