package :utils do
  description 'Setup tools and goodies'
  apt 'vim curl htop' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'vim'
    has_apt 'curl'
    has_apt 'htop'
  end
end
