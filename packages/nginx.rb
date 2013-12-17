package :nginx do
  apt 'nginx' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'nginx'
  end
end