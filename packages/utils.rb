package :utils do
  description 'Setup tools'
  apt 'vim' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'vim'
  end
end