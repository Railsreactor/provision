package :nodejs do
  apt 'python-software-properties python g++ make' do
    pre :install, ['aptitude update']
  end

  runner 'add-apt-repository ppa:chris-lea/node.js -y'

  apt 'nodejs' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'nodejs'
  end
end