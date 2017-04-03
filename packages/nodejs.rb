package :nodejs do
  apt 'python g++ make' do
    pre :install, ['apt-get update']
  end

  runner "curl -sL https://deb.nodesource.com/setup_6.x -o /home/#{opts[:deployer_user]}/nodesource_setup.sh"
  runner "sudo chmod a+x /home/#{opts[:deployer_user]}/nodesource_setup.sh"
  runner "sudo bash /home/#{opts[:deployer_user]}/nodesource_setup.sh"

  apt 'nodejs' do
    pre :install, ['apt-get update']
  end

  verify do
    has_apt 'nodejs'
  end
end
