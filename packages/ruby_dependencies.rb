package :ruby_dependencies do
  description 'Setup Ruby dependencies'
  apt 'libssl-dev zlib1g-dev libreadline-dev libpq-dev'

  verify do
    has_apt 'libssl-dev'
    has_apt 'zlib1g-dev'
    has_apt 'libreadline-dev'
    has_apt 'libpq-dev'
  end
end