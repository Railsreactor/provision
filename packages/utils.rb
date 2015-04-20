package :utils do
  description 'Setup tools and goodies'
  apt 'vim curl htop' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'vim'
    has_apt 'curl'
    has_apt 'htop'
  end
end
