package :ppa do
  apt 'python-software-properties', 'software-properties-common' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'python-software-properties'
    has_apt 'software-properties-common'
  end
end
