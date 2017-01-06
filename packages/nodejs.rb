package :nodejs do
  requires :ppa

  apt 'python g++ make' do
    pre :install, ['apt-get update']
  end

  runner 'add-apt-repository ppa:chris-lea/node.js -y'

  apt 'nodejs' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'nodejs'
  end
end
