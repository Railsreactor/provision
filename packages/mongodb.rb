package :mongodb do
  description 'MongoDB'

  runner 'sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10'
  runner 'echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list'

  apt 'mongodb-org' do
    pre :install, ['aptitude update']
  end

  verify do
    has_apt 'mongodb-org'
  end
end
