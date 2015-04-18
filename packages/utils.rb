package :utils do
  description 'Setup tools'
  apt 'vim curl' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'vim'
    has_apt 'curl'
  end
end
